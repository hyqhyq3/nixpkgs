{ lib, buildGoModule, fetchFromGitHub, installShellFiles }:

buildGoModule rec {
  pname = "wander";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "robinovitch61";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-zz9DqRrylCbUCSBl4wspb8BYfmCyQhMmmYwdsbTExbo=";
  };

  vendorHash = "sha256-0S8tzP5yNUrH6fp+v7nbUPTMWzYXyGw+ZNcXkSN+tWY=";

  ldflags = [ "-s" "-w" ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd wander \
      --fish <($out/bin/wander completion fish) \
      --bash <($out/bin/wander completion bash) \
      --zsh <($out/bin/wander completion zsh)
  '';

  meta = with lib; {
    description = "Terminal app/TUI for HashiCorp Nomad";
    license = licenses.mit;
    homepage = "https://github.com/robinovitch61/wander";
    maintainers = teams.c3d2.members;
  };
}
