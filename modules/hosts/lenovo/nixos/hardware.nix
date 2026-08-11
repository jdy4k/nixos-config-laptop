{ ... }: {
  # T14s Gen (AMD Ryzen 7) hardware: storage, kernel, and platform config.
  flake.nixosModules.lenovo-hardware = { lib, pkgs, modulesPath, ... }: {
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    # Storage
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/a7350229-9019-479b-8f30-96a169cabef9";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/B123-CEDF";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
    swapDevices = [ ];
    boot.supportedFilesystems = [ "ntfs" "btrfs" ];

    # Kernel / boot
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [
      "kvm-amd"
      "mt7921e"  # onboard MediaTek Wi-Fi/BT
      "k10temp"  # AMD CPU temp sensor (coretemp is Intel-only, doesn't apply here)
      "cpuid"
      "v4l2loopback"
    ];
    boot.kernelParams = [ "quiet" "amd_pstate=active" ];
    boot.extraModulePackages = [ ];

    # AMD platform
    hardware.cpu.amd.updateMicrocode = true;
    hardware.enableAllFirmware = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr
        rocmPackages.clr.icd
      ];
    };
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;

    # Maintenance / performance
    zramSwap.enable = true;         # compressed RAM swap; no disk swap is configured
    services.fstrim.enable = true;  # periodic TRIM for the NVMe drive
    services.fwupd.enable = true;   # ThinkPad UEFI/SSD firmware updates (fwupdmgr)
  };
}
