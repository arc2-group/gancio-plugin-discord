{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    blank.url = "github:divnix/blank";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "blank";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  nixConfig = {
    extra-substituters = [
      "https://qrp25.cachix.org"
    ];
    extra-trusted-public-keys = [
      "qrp25.cachix.org-1:6AU4LmQK/m+DBXh3JMJBGe5cR0sw19d5TGg4hH1cUsc="
    ];
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
        };
      in
      {
        packages.default = pkgs.callPackage ./package.nix { };

        devShells.default = pkgs.mkShell {
          #buildInputs = self.checks.${system}.pre-commit.enabledPackages;
          #inherit (self.checks.${system}.pre-commit) shellHook;

          packages =
            with pkgs;
            [
              git
              direnv
              typescript
            ]
            ++ self.packages.${system}.default.nativeBuildInputs;
        };
      }
    );
}
