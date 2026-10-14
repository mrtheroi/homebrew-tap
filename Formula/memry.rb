class Memry < Formula
  desc "Log in to memry and wire its memory MCP into your AI agents"
  homepage "https://github.com/mrtheroi/memry-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.3/memry_1.1.3_darwin_arm64.tar.gz"
      sha256 "31d15f738cea1ec9c59cd169a7ec0b890b57196d7d36b6f86e7d12f9e3a88592"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.3/memry_1.1.3_darwin_amd64.tar.gz"
      sha256 "71dfd1cf02572393a291ad0ab4ef0998aa6c2a014c2c0e942bd5b1402004940f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.3/memry_1.1.3_linux_arm64.tar.gz"
      sha256 "ef004f4efcce94d67838ea836ba57b2884c0e405a7fab82b2046a7fa5bc9a88b"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.3/memry_1.1.3_linux_amd64.tar.gz"
      sha256 "e89dd76a9c8c4c4518765138bc0be6dc5e13f5bc44fd9f1a71feb09f54b9a88d"
    end
  end

  def install
    libexec.install "memry"

    # memry setup writes this command into the agents' configs, so it must be the
    # stable opt path (not the versioned Cellar one) and must not rely on PATH.
    (bin/"memry").write <<~SH
      #!/bin/bash
      export MEMRY_EXECUTABLE="#{opt_bin}/memry"
      exec "#{libexec}/memry" "$@"
    SH
  end

  test do
    assert_equal "Memry #{version}\n", shell_output("#{bin}/memry --version")
  end
end
