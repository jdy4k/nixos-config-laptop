{ ... }: {
  flake.nixosModules.lenovo-networking = {
    networking.hostName = "lenovo";
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;
  };
}
