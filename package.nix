{
  lib,
  buildNpmPackage,
}:

buildNpmPackage {
  pname = "gancio-plugin-discord";
  version = "1.0.0";

  src = ./.;

  npmDepsHash = "sha256-YpFCNyzPqTCxM8AXxaDskuU15p/3Q4OCGcH2d8aYI+I=";

  npmBuildScript = "build";

  postInstall = ''
    mkdir -p $out
    cp dist/index.js $out/index.js
  '';

  meta = {
    description = "Gancio plugin for Discord";
    homepage = "https://git.gay/QueerResourcesRiga/gancio-plugin-discord";
    license = lib.licenses.agpl3Plus;
    platforms = lib.platforms.linux;
  };
}
