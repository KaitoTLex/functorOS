{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.liminalOS.extras.gaming;
in
{
  options.liminalOS.extras.gaming = {
    enable = lib.mkEnableOption "gaming";
    utilities = {
      hamachi.enable = lib.mkEnableOption "hamachi";
      gamemode = {
        enable = lib.mkEnableOption "gamemode";
        gamemodeUsers = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = ''
            List of users to add to the gamemode group. Gamemode will likely not work unless you add your user to the group!
          '';
        };
      };
    };
    roblox.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to install the Roblox Sober flatpak automatically. Note that this will enable the nix-flatpak service and automatic flatpak updates.`
      '';
    };
  };
  config = lib.mkIf cfg.enable (
    let
      forAllGamemodeUsers = lib.genAttrs cfg.utilities.gamemode.gamemodeUsers;
    in
    {
      environment.systemPackages = with pkgs; [
        ryubing
        lutris
        # heroic
        mangohud
        mangojuice
        r2modman

        # modrinth-app
        prismlauncher
        # (modrinth-app.overrideAttrs (oldAttrs: {
        #   buildCommand =
        #     ''
        #       gappsWrapperArgs+=(
        #           --set GDK_BACKEND x11
        #           --set WEBKIT_DISABLE_DMABUF_RENDERER 1
        #       )
        #     ''
        #     + oldAttrs.buildCommand;
        # }))

        (wine-discord-ipc-bridge.overrideAttrs (
          final: prev: {
            meta.platforms = prev.meta.platforms ++ [ "x86_64-linux" ];
          }
        ))
      ];

      liminalOS.programs.flatpak.enable = true;

      services.flatpak.packages = lib.mkIf cfg.roblox.enable [
        "org.vinegarhq.Sober"
      ];

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };

      programs.gamescope.enable = true;

      programs.gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          general = {
            renice = 10;
          };
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode engaged'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode disengaged'";
          };
        };
      };

      liminalOS.config.extraUnfreePackages = lib.mkIf config.liminalOS.config.allowUnfree [
        "modrinth-app"
        "modrinth-app-unwrapped"
        "ModrinthApp"
        "steam"
        "steam-unwrapped"
      ];

      users.users = forAllGamemodeUsers (_: {
        extraGroups = [ "gamemode" ];
      });

      services.logmein-hamachi.enable = cfg.utilities.hamachi.enable;
      programs.haguichi.enable = cfg.utilities.hamachi.enable;

      nixpkgs.config.packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          extraPkgs =
            pkgs: with pkgs; [
              xorg.libXcursor
              xorg.libXi
              xorg.libXinerama
              xorg.libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib
              libkrb5
              (writeShellScriptBin "launch-gamescope" ''
                (sleep 1; pgrep gamescope| xargs renice -n -11 -p)&
                exec gamescope "$@"
              '')
              keyutils
            ];
        };
      };

      warnings =
        if cfg.utilities.gamemode.enable && (builtins.length cfg.utilities.gamemode.gamemodeUsers == 0) then
          [
            ''You enabled gamemode without setting any gamemode users in `liminalOS.extras.gaming.utilities.gamemode.gamemodeUsers. Gamemode is unlikely to work unless you add your user to gamemodeUsers.''
          ]
        else
          [ ];

      assertions = [
        {
          assertion = !cfg.roblox.enable || (config.liminalOS.config.allowUnfree && cfg.roblox.enable);
          message = ''
            You enabled Roblox but did not allow unfree software in liminalOS! Roblox is installed using the Sober Flatpak <sober.vinegarhq.org>, which is a proprietary unfree package! You must set liminalOS.config.allowUnfree to enable Roblox.
          '';
        }
      ];
    }
  );
}
