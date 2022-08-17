{ config, pkgs, dotfiles, ... }:

{
  home = {
    username = "goldstein";
    homeDirectory = "/home/goldstein";
    stateVersion = "22.11";
    file = pkgs.lib.genAttrs
      [
        ".ghc"
        ".p10k.zsh"
        ".config/alacritty"
        ".config/nvim"
        ".config/rofi"
        ".config/wired"
        ".config/yubikey-touch-detector"
        ".config/bspwm/desktop.jpg"
      ]
      (name: {
        source = "${dotfiles}/${name}";
        recursive = true;
      });
  };

  xsession = {
    enable = true;
    windowManager.bspwm = import ./home/bspwm.nix pkgs;
  };

  programs = {
    command-not-found.enable = true;
    password-store.enable = true;
    zathura.enable = true;

    zsh = {
      enable = true;
      initExtra = builtins.readFile "${dotfiles}/.zshrc";
      sessionVariables = {
        CARGO_TARGET_DIR = "/target/misc";
      };
    };

    direnv = import ./home/direnv.nix;
    git = import ./home/git.nix pkgs.gitAndTools.gitFull;
  };

  services = {
    pass-secret-service.enable = true;
    sxhkd = {
      enable = true;
      extraConfig = builtins.readFile "${dotfiles}/.config/sxhkd/sxhkdrc";
    };

    espanso = import ./home/espanso.nix;
    polybar = import ./home/polybar.nix pkgs;
  };

  xdg.mimeApps.associations.removed = {
    "application/pdf" = "chromium-browser.desktop";
  };
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";
  };
}
