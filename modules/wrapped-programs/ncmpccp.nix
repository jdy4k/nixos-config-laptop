{
  inputs,
  lib,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: let
    ncmpcppConf =
      pkgs.writeText "conf"
      ''
        lyrics_directory=~/music/.lyrics
        mpd_music_dir=~/music
      '';
  in {
    packages.ncmpcpp = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.ncmpcpp;
      flags = {
        "-c" = "${ncmpcppConf}";
      };
    };
  };
}
