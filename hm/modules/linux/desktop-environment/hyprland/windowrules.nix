{ config, lib, ... }:
let
  cfg = config.liminalOS.desktop.hyprland;
in
{
  config.wayland.windowManager.hyprland.settings.windowrulev2 =
    lib.mkIf config.liminalOS.desktop.hyprland.enable
      (
        [
          "opacity 0.90 0.90,class:^(librewolf)$"
          "opacity 0.90 0.90,class:^(floorp)$"
          "opacity 0.90 0.90,class:^(firefox)$"
          "opacity 0.90 0.90,class:^(zen-alpha)$"
          "opacity 0.90 0.90,class:^(zen-beta)$"
          "opacity 0.90 0.90,class:^(zen)$"
          "opacity 0.90 0.90,class:^(Brave-browser)$"
          "opacity 0.80 0.80,class:^(Steam)$"
          "opacity 0.80 0.80,class:^(steam)$"
          "opacity 0.80 0.80,class:^(steamwebhelper)$"
          "opacity 0.80 0.80,class:^(Spotify)$"
          "opacity 0.80 0.80,initialTitle:^(Spotify Premium)$"
          "opacity 0.80 0.80,initialTitle:^(Spotify Free)$"
          "opacity 0.80 0.80,class:^(code-oss)$"
          "opacity 0.80 0.80,class:^(Code)$"
          "opacity 0.80 0.80,class:^(code-url-handler)$"
          "opacity 0.80 0.80,class:^(code-insiders-url-handler)$"
          "opacity 0.80 0.80,class:^(kitty)$"
          "opacity 0.80 0.80,class:^(neovide)$"
          "opacity 0.80 0.80,class:^(org.kde.dolphin)$"
          "opacity 0.80 0.80,class:^(org.gnome.Nautilus)$"
          "opacity 0.80 0.80,class:^(org.kde.ark)$"
          "opacity 0.80 0.80,class:^(nwg-look)$"
          "opacity 0.80 0.80,class:^(qt5ct)$"
          "opacity 0.80 0.80,class:^(qt6ct)$"
          "opacity 0.80 0.80,class:^(kvantummanager)$"
          "opacity 0.80 0.80,class:^(waypaper)$"
          "opacity 0.80 0.80,class:^(org.pulseaudio.pavucontrol)$"
          "opacity 0.80 0.80,class:^(com.github.wwmm.easyeffects)$"
          "opacity 0.80 0.80,class:^(thunderbird)$"

          "opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$ # Clapper-Gtk"
          "opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$ # Flatseal-Gtk"
          "opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$ # Cartridges-Gtk"
          "opacity 0.80 0.80,class:^(com.obsproject.Studio)$ # Obs-Qt"
          "opacity 0.80 0.80,class:^(gnome-boxes)$ # Boxes-Gtk"
          "opacity 0.80 0.80,class:^(discord)$ # Discord-Electron"
          "opacity 0.80 0.80,class:^(vesktop)$ # Vesktop-Electron"
          "opacity 0.80 0.80,class:^(Element)$ # Vesktop-Electron"
          "opacity 0.80 0.80,class:^(ArmCord)$ # ArmCord-Electron"
          "opacity 0.80 0.80,class:^(app.drey.Warp)$ # Warp-Gtk"
          "opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$ # ProtonUp-Qt"
          "opacity 0.80 0.80,class:^(yad)$ # Protontricks-Gtk"
          "opacity 0.80 0.80,class:^(signal)$ # Signal-Gtk"
          "opacity 0.80 0.80,class:^(io.github.alainm23.planify)$ # planify-Gtk"
          "opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$ # Upscaler-Gtk"
          "opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$ # VideoDownloader-Gtk"
          "opacity 0.80 0.80,class:^(lutris)$ # Lutris game launcher"

          "opacity 0.80 0.70,class:^(pavucontrol)$"
          "opacity 0.80 0.70,class:^(blueman-manager)$"
          "opacity 0.80 0.70,class:^(nm-applet)$"
          "opacity 0.80 0.70,class:^(nm-connection-editor)$"
          "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"

          "float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$"
          "float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$"
          "float,title:^(Picture-in-Picture)$"
          "float,class:^(librewolf)$,title:^(Library)$"
          "float,class:^(floorp)$,title:^(Library)$"
          "float,class:^(zen-alpha)$,title:^(Library)$"
          "float,class:^(zen-beta)$,title:^(Library)$"
          "float,class:^(zen)$,title:^(Library)$"
          ''float,class:^(zen)$,title:^(.*Extension: \(Bitwarden Password Manager\).*)$''
          "float,class:^(vlc)$"
          "float,class:^(kvantummanager)$"
          "float,class:^(qt5ct)$"
          "float,class:^(qt6ct)$"
          "float,class:^(nwg-look)$"
          "float,class:^(org.kde.ark)$"
          "float,class:^(org.pulseaudio.pavucontrol)$"
          "float,class:^(com.github.rafostar.Clapper)$ # Clapper-Gtk"
          "float,class:^(app.drey.Warp)$ # Warp-Gtk"
          "float,class:^(net.davidotek.pupgui2)$ # ProtonUp-Qt"
          "float,class:^(yad)$ # Protontricks-Gtk"
          "float,class:^(eog)$ # Imageviewer-Gtk"
          "float,class:^(io.github.alainm23.planify)$ # planify-Gtk"
          "float,class:^(io.gitlab.theevilskeleton.Upscaler)$ # Upscaler-Gtk"
          "float,class:^(com.github.unrud.VideoDownloader)$ # VideoDownloader-Gkk"
          "float,class:^(blueman-manager)$"
          "float,class:^(nm-applet)$"
          "float,class:^(nm-connection-editor)$"
          "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
          "opacity 0.80 0.80,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
          "opacity 0.80 0.80,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"

          ''size 70% 70%,class:^(zen)$,title:^(.*Extension: \(Bitwarden Password Manager\).*)$''
          "size 50% 50%,class:^(org.pulseaudio.pavucontrol)"

          "stayfocused, class:^(pinentry-)" # fix pinentry losing focus
        ]
        ++ (lib.optionals cfg.fcitx5.enable [
          "pseudo, class:^(fcitx)"
        ])
      );
}
