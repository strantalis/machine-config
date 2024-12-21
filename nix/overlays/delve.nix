self: super: 
{
  delve = super.delve.overrideAttrs (old: rec {
    version = "1.23.3"; # Replace with the desired version

    src = self.fetchFromGitHub {
    owner = "go-delve";
    repo = "delve";
    rev = "v${version}";
    hash = "sha256-+qC5fFBuQchz1dMP5AezWkkD2anZshN1wIteKce0Ecw=";
  };
  });
}