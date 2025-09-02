{ pkgs, ... }:
let
  inherit (pkgs) callPackage;
in
final: prev: {
  wine-discord-ipc-bridge = callPackage ./by-name/wine-discord-ipc-bridge { };
  hyprlandPlugins.hyprscroller = callPackage ./by-name/hyprscroller { };
  mesa = callPackage ./by-name/hyprscroller { };
}
