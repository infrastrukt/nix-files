{ stdenv, pkgs, fetchgit }:

let
  pkgsUnstable = import
  (
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  ) { };
in
  stdenv.mkDerivation rec
  {
    name = "safepaste";
    src = fetchgit
    {
      url = "https://github.com/jeaye/safepaste.git";
      deepClone = true;
      rev = "d6e97b3eb194170cf3873ccd1c4869cd3180dd06";
      sha256 = "190hbmbi3b8f7scc4i3c6wn71wz1x18aa83rqkds44r8mky5h4jn";
    };
    __noChroot = true;
    buildInputs = [ pkgsUnstable.boot pkgs.nodejs ];
    buildPhase =
    ''
      # For boot
      export BOOT_HOME=$PWD
      export BOOT_LOCAL_REPO=$PWD

      # For npm
      export HOME=$PWD

      ${pkgsUnstable.boot}/bin/boot build
    '';
    installPhase =
    ''
      mkdir -p $out/{bin,share}
      install -m 0644 target/safepaste.jar $out/bin/
      install -m 0755 tool/clean-expired $out/bin/
      install -m 0755 tool/encrypt $out/bin/
      install -m 0755 tool/ban $out/bin/
      install -m 0644 src/paste/about $out/share/
      install -m 0644 src/paste/donate $out/share/
    '';
  }
