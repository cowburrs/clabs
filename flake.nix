{
  description = "Minimal development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }@outputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      godotVersion = "4_7";
      godotPkgs = pkgs."godotPackages_${godotVersion}";
      godot = godotPkgs.godot;
      exportTemplate = godotPkgs.export-templates-bin;

      exportPresetName = "Web";
      outputFileName = "my-game.x86_64";
      exportMode = "--export-release";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          godot_4_7
          gdscript-formatter
        ];
        shellHook = ''
          export PS1="\n\[\033[1;32m\][nix-shell:\w]\$\[\033[0m\] "
          export homeVariable=$TMPDIR
          mkdir -p "$homeVariable/.local/share/godot/export_templates"
          ln -s ${exportTemplate}/share/godot/export_templates/* \
          "$homeVariable/.local/share/godot/export_templates/"
          alias godot="HOME=$homeVariable godot"
        '';

      };
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "godot-project-export";
        name = "clabs";
        src = ./.;
        nativeBuildInputs = [ godot ];
        dontConfigure = true;
        buildPhase = ''
          runHook preBuild

          mkdir -p ",/.config/godot"
          export HOME="$TMPDIR/home"
          mkdir -p "$HOME/.local/share/godot/export_templates"
          cp -rL ${exportTemplate}/share/godot/export_templates/* \
          "$HOME/.local/share/godot/export_templates/"
          chmod -R u+w "$HOME/.local/share/godot/export_templates/"

          mkdir -p "$out"

          ${godot}/bin/godot4 --headless --export-release "Web" "$out/clabs"

          runHook postBuild
        '';
        # installPhase = ''
        #   runHook preInstall
        #   mkdir -p $out/clabs
        #   mv ./* $out/
        #   runHook postInstall
        # '';
      };

    };
}
