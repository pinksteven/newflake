{
  inputs,
  self,
  ...
}: {
  flake.overlays = import ../overlays {
    inherit inputs;
    outputs = self;
  };
}
