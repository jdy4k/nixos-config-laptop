{ ... }: {
  flake.nixosModules.lenovo-services = {
    security.polkit.enable = true;

    services.flatpak.enable = true;
    services.udisks2.enable = true;
    services.printing.enable = true;

    programs.corectrl.enable = true;
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;
  };
}
