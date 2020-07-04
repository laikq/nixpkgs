{ lib, fetchurl, appimageTools }:

let
  pname = "friture";
  version = "0.41";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/tlecomte/friture/releases/download/v0.41/friture-0.41-20191208.AppImage";
    sha256 = "1926mrqzdjhhpa9h8x5h5qs6z40qpl3xkrsspfcmipjhvz2xmln5";
  };

  appimageContents = appimageTools.extractType2 {
    inherit name src;
  };

in appimageTools.wrapType2 {
  inherit name src;

  extraPkgs = pkgs: with pkgs; [ portaudio ];

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D ${appimageContents}/friture.desktop $out/share/applications/friture.desktop
  '';

  meta = with lib; {
    description = "A real-time audio analyzer";
    homepage = "http://friture.org/";
    license = licenses.gpl3;
    platforms = platforms.linux; # fails on Darwin
    maintainers = [ maintainers.laikq ];
  };
}
