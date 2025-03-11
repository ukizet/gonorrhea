{
  description = "my project description";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; # Фиксация на канале 24.11
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true; # Разрешить несвободные пакеты
        };
      in {
        devShells.default = import ./shell.nix { inherit pkgs; };
      }
    );
}
