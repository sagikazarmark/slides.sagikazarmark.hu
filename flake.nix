{
  description = "My slides";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    mynur.url = "github:sagikazarmark/nur-packages";
    mynur.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, mynur }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [
            (final: prev: {
              quarto = mynur.packages.${system}.quarto;
            })
          ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            quarto
            netlify-cli

            # python310Packages.jupyter
            # python310Packages.matplotlib
            # python310Packages.plotly
          ];

          shellHook = ''
            echo "quarto $(quarto --version)"
            netlify --version
          '';
        };
      });
}
