self: super: {
  delve = super.delve.overrideAttrs (old: rec {
    version = "1.24.0"; # Replace with the desired version

    src = self.fetchFromGitHub {
      owner = "go-delve";
      repo = "delve";
      rev = "v${version}";
      hash = "sha256-R1MTMRAIceHv9apKTV+k4d8KoBaRJSZCflxqhgfQWu4=";
    };

    vendorHash = null;
  });
}
