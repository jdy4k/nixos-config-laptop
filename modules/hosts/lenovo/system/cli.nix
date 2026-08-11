# CLI tools, installed globally.
{ self, ... }: {
  flake.nixosModules.lenovo-cli = { pkgs, ... }: let
    selfpkgs = self.packages.${pkgs.system};
  in {
    environment.systemPackages = (with pkgs; [
      # Nix tooling
      nil
      nixd
      statix
      alejandra
      manix
      nix-inspect

      # General utilities
      file
      unzip
      zip
      atool
      p7zip
      wget
      killall
      sshfs
      fzf
      htop
      btop
      eza
      fd
      zoxide
      dust
      ripgrep
      tree
      tree-sitter
      imagemagick
      ffmpeg-full
      yt-dlp
      wl-clipboard
      yazi
    ]) ++ [
      # Wrapped packages from this flake
      selfpkgs.git
      selfpkgs.neovimDynamic
    ];
  };
}
