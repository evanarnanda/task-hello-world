# shell.nix

let
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
    pkgs = import <nixpkgs> { 
        config = { 
            allowUnfree = true;
        };
        overlays = [];
    };
    git = pkgs.git.overrideAttrs(oldAttrs: rec {
        version = "2.42.0";
    });

    podman = pkgs.podman.overrideAttrs(oldAttrs: rec {
        version = "4.7.2";
    });
in

pkgs.mkShell
{
    nativeBuildInputs = with pkgs; [
        pkgs.git
        pkgs.podman
        python312
        python312Packages.pip
        pkgs.pdm
    ];
    
    shellHook = ''
    alias docker=podman
    export NIX_SHELL_DIR=$PWD/.nix-shell
    export LC_ALL=C
    export LANG=C.utf8
  '';
}