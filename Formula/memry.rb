class Memry < Formula
  desc "Log in to memry and wire its memory MCP into your AI agents"
  homepage "https://github.com/mrtheroi/memry-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.0.0/memry_1.0.0_darwin_arm64.tar.gz"
      sha256 "82047042f78e45127eb4325ce1ab832b99fb18f0e3d6ad574fd2783381241caf"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.0.0/memry_1.0.0_darwin_amd64.tar.gz"
      sha256 "f4811b3d33162d7bec1bb6afa2eb9da79e2d011227fa38664038b5e8c3a1e154"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.0.0/memry_1.0.0_linux_arm64.tar.gz"
      sha256 "0bd38ec906e23b893effcd6731093244e647c1b285be8233250af6e4f5e0d6bb"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.0.0/memry_1.0.0_linux_amd64.tar.gz"
      sha256 "9d8aaa9a3d675e0db9231e303eb54fd44d15d6498bfb68bfa966482cea188233"
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
