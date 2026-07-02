{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.functorOS.desktop;
in
{
  options.functorOS.desktop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.functorOS.enable;
      description = ''
        Whether to enable the functorOS desktop environment.
      '';
    };
    niri.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.enable;
      description = ''
        Whether to enable Niri. Sets up an opinionated configuration at the system and user level.
      '';
    };
    sway.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to enable Sway compositor. Sets up a system-level Sway installation
        with wlroots portals. Configure the rice via functorOS.desktop.sway in Home Manager.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.portal = lib.mkIf cfg.sway.enable {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
    };

    programs.niri = {
      enable = cfg.niri.enable;
      useNautilus = cfg.niri.enable;
      package = pkgs.niri;
    };

    environment.systemPackages = lib.mkIf cfg.niri.enable [ pkgs.xwayland-satellite ];

    programs.sway = lib.mkIf cfg.sway.enable {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    programs.xwayland.enable = lib.mkIf cfg.niri.enable (lib.mkForce true);

    niri-flake.cache.enable = false;

    systemd.user.services.niri-flake-polkit.enable = false;

    services.xserver.enable = false;

    services.xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };
  };
}
