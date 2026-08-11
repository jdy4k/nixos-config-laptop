{ self, ... }: {
  flake.nixosModules.lenovo-users = { pkgs, ... }: {
    users.users.jdy4k = {
      isNormalUser = true;
      description = "jdy4k's account";
      extraGroups = [ "wheel" "networkmanager" "video" "render" ];
      shell = self.packages.${pkgs.system}.fish;
      initialPassword = "12345";
    };
  };
}
