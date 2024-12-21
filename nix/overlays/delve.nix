self: super: 
{
  delve = import self.inputs.nixpkgs-master { inherit (final) system; }.delve;
}