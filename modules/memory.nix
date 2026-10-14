{ ... }:

{
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 6 * 1024; # MiB
  }];

  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.zpool=zsmalloc"
    "zswap.max_pool_percent=20"
  ];

  services.earlyoom.enable = true;
}
