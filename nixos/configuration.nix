{ config, lib, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "quiet" ];

  security.doas.enable = true;
  security.sudo.enable = false;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  boot.kernelPackages = pkgs.linuxPackages-rt_latest;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
    LC_MESSAGES = "en_US.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
    LANGUAGE = "ru_RU";
    LC_ALL = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;

    modules = with pkgs; [
      xf86_input_wacom
      xlibinput-calibrator
      fusuma
      xorg.xf86inputlibinput
    ];
    wacom.enable = true;

    # displayManager = {
    #   gdm.enable = true;
    #   gdm.wayland = true;
    # };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };

  services.displayManager = {
    sddm = {
      enable = true;
      theme = "catpuccin-mocha";
      package = pkgs.kdePackages.sddm;
      settings = { Theme = { CursorTheme = "Bibata-Modern-Ice"; }; };
    };
    defaultSession = "none+awesome";
  };

  # services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "none+awesome";
  # services.xrdp.openFirewall = true;

  # services.teamviewer.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us,ru";
    xkbOptions = "grp:win_space_toggle";
  };

  services.acpid.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.artem = {
    isNormalUser = true;
    # initialPassword = "pi";
    shell = pkgs.zsh;
    extraGroups =
      [ "wheel" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
  };
  programs.nix-ld.enable = true;

  security.polkit.enable = true;

  programs.direnv.enable = true;

  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
  xdg.portal.config.common.default = "*";

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  programs.dconf.enable = true;
  programs.zsh.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gtk2;
  };
  # programs.ssh.startAgent = true;

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}

