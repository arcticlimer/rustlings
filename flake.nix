{
  description = "Algorithms and data structures";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        rustlings = pkgs.rustPlatform.buildRustPackage rec {
          pname = "rustlings";
          version = "4.6.0";
          src = ./.;
          cargoSha256 = "sha256-t29XFL0xbYZLwKCs+tLg92fgB46XO+cMYkEm325iJgw=";
          doCheck = false;
        };
      in
      rec {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            rustc
            cargo
            rustlings
            rust-analyzer
            rustfmt
            clippy
          ];
        };
      }
    );
}
