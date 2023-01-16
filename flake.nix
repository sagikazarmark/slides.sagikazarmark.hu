{
  description = "My slides";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # quarto

            python310Packages.jupyter
            python310Packages.matplotlib
            python310Packages.plotly
          ];

          shellHook = ''
            echo -e "Welcome to the developer console!\n"
          '';
        };
      });
}
