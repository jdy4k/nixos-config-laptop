# Portals, default applications, and user directories.
{ ... }: {
  flake.nixosModules.lenovo-xdg = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = [ "gtk" ];
    };

  xdg.mime = {
      enable = true;
      defaultApplications = {
        # Browser
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";

        "inode/directory" = "pcmanfm.desktop";

        # PDF/Books
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
        "application/epub+zip" = "org.pwmt.zathura-pdf-mupdf.desktop";

        # Image
        "image/*" = "imv.desktop";

        # Video
        "video/*" = "mpv.desktop";

        # Audio
        "audio/*" = "mpv.desktop";
      };
    };

    hjem.users.jdy4k = {
      directory = "/home/jdy4k";
      files.".config/user-dirs.dirs".text = ''
        XDG_DOCUMENTS_DIR="$HOME/local_documents"
        XDG_DOWNLOAD_DIR="$HOME/local_downloads"
        XDG_MUSIC_DIR="$HOME/local_music"
        XDG_PICTURES_DIR="$HOME/local_pictures"
        XDG_DESKTOP_DIR="$HOME/.desktop"
      '';
    };
  };
}
