{self, ...}: {
  flake.nixosModules.lenovo-nix = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.system}";
  in  {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;

    environment.sessionVariables = {
      NH_FLAKE = "/home/jdy4k/nixconf";
    };

    environment.systemPackages = [
      pkgs.nil
      pkgs.nixd
      pkgs.statix
      pkgs.alejandra
      pkgs.manix
      pkgs.nix-inspect
      pkgs.nix-search-tv
      pkgs.fzf

      selfpkgs.nh
      selfpkgs.ns
    ];
  };
}
