{pkgs ? (
  let
    inherit (builtins) fetchTree fromJSON readFile;
    inherit ((fromJSON (readFile ./flake.lock)).nodes) nixpkgs;
  in
  import (fetchTree nixpkgs.locked) {}
  ), writeShellScriptBin ? null, name ? null
}:
  pkgs.mkShell {
    hardeningDisable = ["all"];
    name = "FSAI-Protokoll";
    buildInputs = with pkgs; [
      gnumake
      texliveFull
    ];

    shellHook = ''
    '';
  }
