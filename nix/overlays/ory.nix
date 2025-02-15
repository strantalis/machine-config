self: super: {
  ory = super.ory.overrideAttrs (old: rec {
    version = "v1.1.0"; # Replace with the desired version

    src = self.fetchFromGitHub {
      owner = "ory";
      repo = "cli";
      rev = "refs/tags/${version}";
      # Update this hash for the desired version
      hash = "sha256-+Su2FIuCb2vpPW/OCOTzqQOZPpY9gGRbwylSepLh2hk=";
    };

    # Update vendorHash for the desired version
    vendorHash = "sha256-VXaMc4VnHPljVugJyuGn8EQvNUBkEhbvepg2p7vw2EY=";

    # Add ldflags for versioning
    ldflags = [
      "-s"
      "-w"
      "-X github.com/ory/cli/buildinfo.Version=${version}"
      "-X github.com/ory/cli/buildinfo.GitHash=${src.rev}"
    ];
  });
}
