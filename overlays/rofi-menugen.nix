final: prev: { 
  rofi-menugen = prev.rofi-menugen.overrideAttrs(o: {
    patches = (o.patches or []) ++ [
      ./rofi-menugen-overlay.patch
    ];
  });
}
