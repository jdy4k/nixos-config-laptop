{ ... }: {
  flake.nixosModules.lenovo-services = {
    security.polkit.enable = true;

    services.flatpak.enable = true;
    services.udisks2.enable = true;
    services.printing.enable = true;

    programs.corectrl.enable = true;
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    services.chrony = {
      enable = true;
      enableNTS = true;
      servers = [
          "server time.cloudflare.com iburst nts"
          "server ntppool1.time.nl iburst nts"
          "server nts.netnod.se iburst nts"
          "server ptbtime1.ptb.de iburst nts"
          "server time.dfm.dk iburst nts"
          "server time.cifelli.xyz iburst nts"
       ];
    };
  };
}
