{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # browsers
    firefox
    chromium
    tor-browser-bundle-bin
    # messengers
    slack
    # discord
    tdesktop
    weechat
    zulip
    nheko
    # stuff
    appimage-run
    lm_sensors
    qbittorrent
    playerctl
  ];
  programs.light.enable = true;
}
