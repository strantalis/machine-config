self: super: {
  ory = super.buildGoModule.overrideAttrs (old: rec {
    version = "1.1.0"; # Replace with the desired version

    src = self.fetchFromGitHub {
      owner = "ory";
      repo = "cli";
      rev = "refs/tags/v${version}";
      # Update this hash for the desired version
      hash = "sha256-06fsw697lli9qddn901xjqz9j0x9ygj0ikkg7plnnvw2icabcazr";
    };

    # Update vendorHash for the desired version
    vendorHash = "sha256-VXaMc4VnHPljVugJyuGn8EQvNUBkEhbvepg2p7vw2EY=";
  });
}