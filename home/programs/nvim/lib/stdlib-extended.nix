nixpkgsLib: let
  mkNvimLib = import ./.;
in
  nixpkgsLib.extend (self: super: {
    nvim = mkNvimLib { lib = self; };
    literalExpression = super.literalExpression or super.literalExample;
    literalDocBook = super.literalDocBook or super.literalExample;
  })
