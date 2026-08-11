# Niri desktop: compositor, terminal, auto-login, and session variables.
{ self, ... }: {
  flake.nixosModules.lenovo-desktop = { pkgs, lib, ... }: let
    selfpkgs = self.packages.${pkgs.system};
  in {
    programs.niri.enable = true;
    programs.niri.package = selfpkgs.niri;

    environment.systemPackages = [
      selfpkgs.foot
      pkgs.pcmanfm
    ];

    # Log straight into niri on boot
    services.displayManager.autoLogin.user = "jdy4k";
    services.displayManager.defaultSession = lib.mkDefault "niri";
    services.getty.autologinUser = "jdy4k";

    environment.sessionVariables = {
      NIXOS_XDG_OPEN_USE_PORTAL = "1";
      QT_QPA_PLATFORM = "wayland";
      XDG_CURRENT_DESKTOP = "niri";

      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";
    };
  };
}
