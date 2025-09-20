{
  outputs,
  inputs,
}: {
  additions = final: prev:
    import ../pkgs {pkgs = final;};
}
