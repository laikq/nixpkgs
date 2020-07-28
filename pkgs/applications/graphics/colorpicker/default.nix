{ xlibs, stdenv, fetchFromGitHub, pkg-config, lib }:

stdenv.mkDerivation {
  pname = "colorpicker";
  version = "unstable-2020-06-20";

  buildInputs = [ xlibs.libX11 pkg-config ];

  makeFlags = [
    "PREFIX=$(out)"
  ];

  src = fetchFromGitHub {
    owner = "ym1234";
    repo = "colorpicker";
    rev = "b48e03610a02d43d55d0fa0c96132186e59a560a";
    sha256 = "0wqf1w0hvagr3dbpizi4wj5s5bpscdvlix1qyaawqn28936dx52w";
  };

  meta = with lib; {
    description = "A tool for X11 that writes the color value on your screen at the cursor position to stdout";
    homepage = "https://github.com/ym1234/colorpicker";
    license = licenses.mit;
    maintainers = with maintainers; [ laikq ];
    platforms = platforms.unix;
  };
}
