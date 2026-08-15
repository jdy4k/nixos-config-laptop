{
  inputs = {
    # https://determinate.systems/blog/nixpkgs-cooldown/
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrappers.url = "github:Lassulus/wrappers";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    
    hjem.url = "github:feel-co/hjem";
    focal.url = "github:iynaix/focal";

    # To implement...
    # impermanence.url = "github:nix-community/impermanence";
    # persist-retro.url = "github:Geometer1729/persist-retro";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
