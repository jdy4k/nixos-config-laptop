# Entry point for the lenovo host: assembles the named modules defined by the
# sibling files (each auto-imported by import-tree).
{ inputs, self, lib, ... }: {
  flake.nixosConfigurations.lenovo = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.hjem.nixosModules.default
      self.nixosModules.host-lenovo
    ];
  };

  flake.nixosModules.host-lenovo = {
    imports = [
      self.nixosModules.lenovo-hardware
      self.nixosModules.lenovo-boot
      self.nixosModules.lenovo-battery
      self.nixosModules.lenovo-networking
      self.nixosModules.lenovo-locale
      self.nixosModules.lenovo-nix
      self.nixosModules.lenovo-services
      self.nixosModules.lenovo-users
      self.nixosModules.lenovo-audio
      self.nixosModules.lenovo-input
      self.nixosModules.lenovo-desktop
      self.nixosModules.lenovo-fonts
      self.nixosModules.lenovo-applications
      self.nixosModules.lenovo-variables
      self.nixosModules.lenovo-optimization
      self.nixosModules.lenovo-cli
      self.nixosModules.lenovo-xdg
      self.nixosModules.lenovo-theme
    ];
    nixpkgs.config.allowUnfree = false;
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "broadcom-bt-firmware"
      "b43-firmware"
      "xone-dongle-firmware"
      "facetimehd-calibration"
      "facetimehd-firmware"
    ];
    system.stateVersion = "23.11";
  };
}
