{
  pkgs,
  functorOSInputs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
# stablepkgs = inputs.stablepkgs.legacyPackages.${pkgs.system};
{
  nixpkgs.overlays = [
    (import ../pkgs { inherit pkgs; })
    (final: prev: {
      nix-index-unwrapped = prev.nix-index-unwrapped.overrideAttrs (
        finalAttrs: prevAttrs: {
          version = "0.1.11";
          src = functorOSInputs.nix-index;

          cargoDeps = prev.rustPlatform.fetchCargoVendor {
            inherit (finalAttrs) src;
            hash = "sha256-uSR2JvlL2PhnCuVeAJilPK03PzaNbUs9/lPURtnVU9I=";
          };
        }
      );

      # hyprland = prev.stdenv.mkDerivation { inherit (prev.hyprland) pname version; };
    })
  ];
}
