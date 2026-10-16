class Memry < Formula
  desc "Log in to memry and wire its memory MCP into your AI agents"
  homepage "https://github.com/mrtheroi/memry-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.2.0/memry_1.2.0_darwin_arm64.tar.gz"
      sha256 "988a3a4e25ac36734aad55638ee043f6efdcd6eb056b37e6cd375d2aed46d428"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.2.0/memry_1.2.0_darwin_amd64.tar.gz"
      sha256 "6b3115c73c5a0a1dd41e67b6006c2098f3b1ffd21929abcb7fd77967cc182722"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.2.0/memry_1.2.0_linux_arm64.tar.gz"
      sha256 "9e0a39a544af2a9315ba5d0ee5023cbc6b8d9908994ee68488afbd354f3b984f"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.2.0/memry_1.2.0_linux_amd64.tar.gz"
      sha256 "79d00b77b198c8796cd10548e5572a0294014b5364e87725805b7ea15e56bca0"
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
