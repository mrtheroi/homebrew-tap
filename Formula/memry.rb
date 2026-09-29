class Memry < Formula
  desc "Log in to memry and wire its memory MCP into Claude Code"
  homepage "https://github.com/mrtheroi/memry-cli"
  url "https://github.com/mrtheroi/memry-cli/releases/download/v0.4.0/memry.phar"
  sha256 "00508b2a9745920e664033b01a273da3689d4d0fa0ad0422a35084e98be4c964"
  license "MIT"

  depends_on "php"

  def install
    libexec.install "memry.phar"

    # memry setup writes this command into Claude Code's config, so it must be the
    # stable opt path (not the versioned Cellar one) and must not rely on PATH.
    (bin/"memry").write <<~SH
      #!/bin/bash
      export MEMRY_EXECUTABLE="#{opt_bin}/memry"
      exec "#{Formula["php"].opt_bin}/php" "#{libexec}/memry.phar" "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/memry --version")
  end
end
