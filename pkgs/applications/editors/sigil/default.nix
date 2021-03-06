{ stdenv, mkDerivation, fetchFromGitHub, cmake, pkgconfig, makeWrapper
, boost, xercesc, hunspell, zlib, pcre16
, qtbase, qttools, qtwebengine, qtxmlpatterns
, python3Packages
}:

mkDerivation rec {
  pname = "sigil";
  version = "1.4.2";

  src = fetchFromGitHub {
    repo = "Sigil";
    owner = "Sigil-Ebook";
    rev = version;
    sha256 = "1vn444ax5af1gbhkm9lz46jc7zi4grf16cb4wqyb6hvgj2gbl0iw";
  };

  pythonPath = with python3Packages; [ lxml ];

  nativeBuildInputs = [ cmake pkgconfig makeWrapper ];

  buildInputs = [
    boost xercesc qtbase qttools qtwebengine qtxmlpatterns
    python3Packages.lxml
  ];

  prePatch = ''
    sed -i '/^QTLIB_DIR=/ d' src/Resource_Files/bash/sigil-sh_install
  '';

  dontWrapQtApps = true;

  preFixup = ''
    wrapProgram "$out/bin/sigil" \
       --prefix PYTHONPATH : $PYTHONPATH \
       ''${qtWrapperArgs[@]}
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Free, open source, multi-platform ebook (ePub) editor";
    homepage = "https://github.com/Sigil-Ebook/Sigil/";
    license = licenses.gpl3;
    # currently unmaintained
    platforms = platforms.linux;
  };
}
