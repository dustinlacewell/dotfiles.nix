{ config, pkgs, lib, modulesPath, inputs, secrets, ... }:

{
  ldlework.vm = {
    enable = true;
    graphical = true;
  };

  networking.hostName = "logos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Declare user
  users.users.ldlework = {
    isNormalUser = true;
    group = "ldlework";
    extraGroups = [ "wheel" ];
    createHome = true;
    initialPassword = secrets.logos.ldlework.password;
  };

  users.groups.ldlework = {};

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager = {
      defaultSession = "none+qtile";
    };

    windowManager = {
      qtile.enable = true;
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    emacs
    wget
    brave
    kitty
    xclip
    xorg.xmodmap
    inputs.myhello.defaultPackage.x86_64-linux
    inputs.nixt.defaultPackage.x86_64-linux
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 8000 8080 ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "21.11";
}
