# Graphical applications. CLI tools live in ../cli.nix; hardware-related
# tuning for these apps lives in ./optimization.nix.
{ self, ... }: {
  flake.nixosModules.lenovo-applications = { pkgs, ... }: let
    selfpkgs = self.packages.${pkgs.system};
  in {
    imports = [
      self.nixosModules.mpd
      self.nixosModules.anki
      self.nixosModules.libreoffice
      self.nixosModules.forticlient
    ];
    environment.systemPackages = [
      pkgs.librewolf
      pkgs.imv
      selfpkgs.zathura
      selfpkgs.mpv
    ];
  };
}
