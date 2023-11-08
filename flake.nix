{
  description = "My slides";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
    mynur.url = "github:sagikazarmark/nur-packages";
    mynur.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];

      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: rec {
        devenv.shells = {
          default = {
            packages = with pkgs; [
              quarto
              netlify-cli
              d2

              # python310Packages.jupyter
              # python310Packages.matplotlib
              # python310Packages.plotly
            ] ++ [
              inputs'.mynur.packages.decktape
            ];

            scripts = {
              versions.exec = ''
                echo "quarto $(quarto --version)"
                netlify --version
              '';
            };

            enterShell = ''
              versions
            '';

            # https://github.com/cachix/devenv/issues/528#issuecomment-1556108767
            containers = pkgs.lib.mkForce { };
          };

          ci = devenv.shells.default;
        };
      };
    };
}
