{ self, ... }: {
  flake.nixosModules.lenovo-users = { pkgs, lib, ... }: {
    users.users.admin = {
        isNormalUser = true;
        description  = "System administrator";
        extraGroups  = [ "wheel" ];   # wheel = sudo
        # run `mkpasswd --method=yescrypt` and replace "changeme" w/ the result
        initialHashedPassword = "changeme";           # change with `passwd admin` later
        openssh.authorizedKeys.keys = [
          # (optional) paste your SSH public key here
          # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
        ];
      };
      users.groups.admin = {};
      users.mutableUsers = false;
    
      # --------------------------------------------------------------------
      # 2. Existing daily user – remove from wheel, keep everything else
      # --------------------------------------------------------------------
      users.users.jdy4k = {
        isNormalUser = true;
        description  = "System user";
        extraGroups  = lib.mkForce [ "networkmanager" "audio" "video" ]; # keep useful groups
        initialHashedPassword = "changeme";
        # Remove `wheel` by *not* listing it (mkForce overrides any default)
      };
      users.groups.daily = {};
    
    security = {
      # alias sudo = 'run0'
      run0.enable = true;
      run0.enableSudoAlias = true;
      polkit.enable = true;
      polkit.extraConfig = ''
       polkit.addRule(function(action, subject) {
         if (subject.user == "jdy4k") {
           if (action.id.indexOf("org.nixos") == 0) {
             polkit.log("Caching admin authentication for single NixOS operation");
             return polkit.Result.AUTH_ADMIN_KEEP;
           }
         }
       });
      '';

      # Disable sudo
      sudo.enable = false;
      wrappers = {
          su.enable = lib.mkForce false;
          sudoedit.enable = lib.mkForce false;
          sg.enable = lib.mkForce false;
          fusermount.enable = lib.mkForce false;
          fusermount3.enable = lib.mkForce false;
          pkexec.setuid = lib.mkForce false;
          newgrp.setuid = lib.mkForce false;
          newgidmap.setuid = lib.mkForce false;
          newuidmap.setuid = lib.mkForce false;
          # `mount` Needed for `fileSystems.options`
          # mount.enable = lib.mkForce false;
          # Optional: if you disable mount, disable umount as well
          # umount.enable = lib.mkForce false;
      };

      #users.users.jdy4k = {
      #  isNormalUser = true;
      #  description = "jdy4k's account";
      #  extraGroups = [ "wheel" "networkmanager" "video" "render" ];
      #  shell = self.packages.${pkgs.system}.fish;
      #  initialPassword = "12345";
      #};
    };
  };
}
