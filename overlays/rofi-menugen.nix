{nixpkgs, system, ...}:
final: prev: { 
  rofi-menugen = prev.rofi-menugen.overrideAttrs(o: rec {
    patches = (o.patches or []) ++ [
      ./rofi-menugen-overlay.patch
    ];
    postPatch = ''
      sed -i -e "s|menugenbase|$out/bin/rofi-menugenbase|" menugen
      sed -i -e "s|menugenbase|$out/bin/rofi-menugenbase|" menugencli

      sed -i -e "s|rofi |${nixpkgs.legacyPackages.${system}.rofi}/bin/rofi |" menugen
      sed -i -e "s|sed |${nixpkgs.legacyPackages.${system}.gnused}/bin/sed |" menugenbase
      sed -i -e "s|fzf |${nixpkgs.legacyPackages.${system}.fzf}/bin/fzf |" menugencli
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp menugen $out/bin/rofi-menugen
      cp menugenbase $out/bin/rofi-menugenbase
      cp menugencli $out/bin/fzf-menugen
    '';
  });
}
