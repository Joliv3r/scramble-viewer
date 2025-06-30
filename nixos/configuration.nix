# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];
  networking.hostName = "scrambler"; # Define your hostname.
  boot.blacklistedKernelModules = [ "elan_i2c" ];
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Limit the maximum amount of latest generation entries in the boot menu.
  boot.loader.systemd-boot.configurationLimit = 100;

  # Why is this not on by default?
  boot.tmp.cleanOnBoot = true;

  # List services that you want to enable:
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  time.timeZone = "Europe/Amsterdam";

  # Enable X server
  # services.displayManager.defaultSession = "none+zathura";
  services.xserver = {
    enable = true;
    autorun = false;
    xkb = {
      layout = "us";
      options = "ctrl:nocaps";
    };
    # displayManager.startx = {
    #   enable = true;
    #   generateScript = true;
    # };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
      middleEmulation = true;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Create scrambler user
  users.users.scrambler = {
    isNormalUser = true;
    extraGroups = [ ]
      ++ ( if ( config.networking.networkmanager.enable ) then [ "networkmanager" ] else [ ] );

    packages = with pkgs; [
      zathura
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

