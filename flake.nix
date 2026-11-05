{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs = inputs:
    let
      package =
        { lib
        , stdenv
        , installShellFiles
        , way-displays
        , rofi
        , yq
        , makeWrapper
        , coreutils
        , shellcheck
        }:
        stdenv.mkDerivation (finalAttrs: {
          pname = "rofi-way-displays";
          version = "0.0.1";
          src = ./.;
          strictDeps = true;
          __structuredAttrs = true;
          nativeBuildInputs = [
            installShellFiles
            makeWrapper
            shellcheck
          ];
          buildInputs = [
            way-displays
            yq
          ];
          installCheckInputs = [
            rofi
          ];
          wrapperPath = lib.makeBinPath [
            coreutils
            yq
            way-displays
          ];
          doCheck = true;
          doInstallCheck = true;
          checkPhase = ''
            shellcheck --source-path="$src" rofi-way-displays
          '';
          installPhase = ''
            runHook preInstall

            installBin ./rofi-way-displays
            wrapProgram $out/bin/rofi-way-displays \
               --prefix PATH : "${finalAttrs.wrapperPath}"

            runHook postInstall
          '';

          meta = {
            description = "Rofi script for interacting with way-displays.";
            homepage = "https://github.com/SimSaladin/rofi-way-displays";
            platforms = lib.platforms.linux;
            license = lib.licenses.mit;
            maintainers = [ ];
            mainProgram = "rofi-way-displays";
          };
        });
    in
    {
      packages = builtins.mapAttrs
        (system: pkgs: {
          rofi-way-displays = pkgs.callPackage package { };

          default = inputs.self.packages.${system}.rofi-way-displays;
        })
        inputs.nixpkgs.legacyPackages;
    };
}
