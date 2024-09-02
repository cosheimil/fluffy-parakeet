План статьи:
1. Приветствие
2. Рассказываю о Rapids. Что это?
3. Какие данные будем сегодня щупать и что с ними делаем
4. Тесты
5. Итоги
6. Заключение

Привет, чемпионы! С каждым годом данных все больше и больше, а время обработки данных увеличивается в квадрате... Согласитесь не классно, когда появилась идея для новой фичи, а чтобы опробовать ее нужно ждать 2 часа. Сегодня будем избавляться от таких ситуаций, применяя классный фреймворк Rapids

# Что такое Rapids?
[Rapids](https://docs.rapids.ai/) - open source решение, состоящее из огромного числа библиотек, использующие GPU. Rapids был создан для ускорения аналитики данных и ML, в тоже самое время не ломая разработчикам голову с новым интерфейсом. Вы получаете такое же API, как в всеми привычных Pandas и Scikit-learn. Сегодня же мы заострим внимание на обработке данных, потому что ML на GPU уже не новость

Rapids разработан Nvidia, поэтому использует CUDA, поэтому функции, которые выполнялись по несколько часов, могут выполняться за несколько минут. Так что давайте быстрее переходить к практике!

# На чем тестим?
Возьмем датасет не межгалактических размеров, чтобы не ждать весь понедельник пока выполняться тесты. Например [Flight Status Prediction](https://www.kaggle.com/datasets/robikscube/flight-delay-dataset-20182022) от известного Kaggle Grandmaster'а, цель которого предсказать опоздает ли рейс или его вообще отменят. Попробуем: составить несколько новых фичей, также построим графики и конечно же экспорт в csv, parquet

# Тесты

Загружаем данные:
```python
%%time
column_subset = [
    "FlightDate",
    "Airline",
    "Flight_Number_Marketing_Airline",
    "Origin",
    "Dest",
    "Cancelled",
    "Diverted",
    "CRSDepTime",
    "DepTime",
    "DepDelayMinutes",
    "OriginAirportID",
    "OriginCityName",
    "OriginStateName",
    "DestAirportID",
    "DestCityName",
    "DestStateName",
    "TaxiOut",
    "TaxiIn",
    "CRSArrTime",
    "ArrTime",
    "ArrDelayMinutes",
]

dfs = []
for f in parquet_files:
    dfs.append(pd.read_parquet(f, columns=column_subset))
df = pd.concat(dfs).reset_index(drop=True)

cat_cols = ["Airline", "Origin", "Dest", "OriginStateName", "DestStateName"]
for c in cat_cols:
    df[c] = df[c].astype("category")
```
Всего данных ~20Gb. `Pandas`  их ест за 59s - пробуем `cudf`, поменяв код только тут:
```python
dfs = []
for f in parquet_files:
    dfs.append(cudf.read_parquet(f, columns=column_subset))
df = cudf.concat(dfs).reset_index(drop=True)
```
И получаем результат за 4s. Фантастика! Фиксируем результаты и идем дальше

Пробуем FE: посчитаем самые обычные фичи:
```python
df_agg = df_pf.groupby(['Airline', 'Year'])[['DepDelayMinutes', 'ArrDelayMinutes']].agg(															 ['mean', 'sum', 'max']
)
```
Получаем результаты за 2.37 секунды. Неплохо, но пробуем сегодняшнего героя и получаем результат за 123 мс! Разница в 20 раз - фантастика. Так как мы не думали над оптимизацией, а воспользовались просто другой библиотекой 

Сделаем новую фичу ручками, сгрупировав задержки по рейсам:
```python
df["DelayGroup"] = None
df.loc[df["DepDelayMinutes"] == 0, "DelayGroup"] = "OnTime_Early"
df.loc[
    (df["DepDelayMinutes"] > 0) & (df["DepDelayMinutes"] <= 15), "DelayGroup"
] = "Small_Delay"
df.loc[
    (df["DepDelayMinutes"] > 15) & (df["DepDelayMinutes"] <= 45), "DelayGroup"
] = "Medium_Delay"
df.loc[df["DepDelayMinutes"] > 45, "DelayGroup"] = "Large_Delay"
df.loc[df["Cancelled"], "DelayGroup"] = "Cancelled"
```

# Итоги

...
# Выводы

...