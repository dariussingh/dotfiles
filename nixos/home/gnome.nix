{ config, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 9;
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Alt>1" ];
      switch-to-workspace-2 = [ "<Alt>2" ];
      switch-to-workspace-3 = [ "<Alt>3" ];
      switch-to-workspace-4 = [ "<Alt>4" ];
      switch-to-workspace-5 = [ "<Alt>5" ];
      switch-to-workspace-6 = [ "<Alt>6" ];
      switch-to-workspace-7 = [ "<Alt>7" ];
      switch-to-workspace-8 = [ "<Alt>8" ];
      switch-to-workspace-9 = [ "<Alt>9" ];

      move-to-workspace-1 = [ "<Shift><Alt>1" ];
      move-to-workspace-2 = [ "<Shift><Alt>2" ];
      move-to-workspace-3 = [ "<Shift><Alt>3" ];
      move-to-workspace-4 = [ "<Shift><Alt>4" ];
      move-to-workspace-5 = [ "<Shift><Alt>5" ];
      move-to-workspace-6 = [ "<Shift><Alt>6" ];
      move-to-workspace-7 = [ "<Shift><Alt>7" ];
      move-to-workspace-8 = [ "<Shift><Alt>8" ];
      move-to-workspace-9 = [ "<Shift><Alt>9" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
      ];
    };
    
    # Alacritty
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Open Alacritty (Copilot Key)";
      command = "${pkgs.alacritty}/bin/alacritty";
      binding = "<Shift><Super>TouchpadOff"; # Left-Shift + Left-Meta (Super) + F23
    };

    # File Explorer
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Open File Explorer";
      command = "${pkgs.nautilus}/bin/nautilus";
      binding = "<Super>e";
    };

    # VSCode
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Open VSCode";
      command = "${pkgs.vscode}/bin/code";
      binding = "<Super>period"; # "." is "period"
    };

    # Settings
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name = "Open Settings";
      command = "gnome-control-center";
      binding = "<Super><Shift>p";
    };

    # Brave
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
      name = "Open Brave";
      command = "${pkgs.brave}/bin/brave";
      binding = "<Super>b";
    };
  };
}
