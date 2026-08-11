# Application tuning for the T14s Gen 3 AMD (Ryzen 6000 / Radeon 680M iGPU).
{ ... }: {
  flake.nixosModules.lenovo-variables = { ... }: {
    environment.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
