class Memry < Formula
  desc "Log in to memry and wire its memory MCP into your AI agents"
  homepage "https://github.com/mrtheroi/memry-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.2/memry_1.1.2_darwin_arm64.tar.gz"
      sha256 "163420e93f65b917b27e3429affc94ec39bd4caf8b818e83a0bc3398d5d9a6d0"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.2/memry_1.1.2_darwin_amd64.tar.gz"
      sha256 "7c9a1da24f51fba578ad1a596449d7a31156493926ef98a5a7154aff7d036c0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.2/memry_1.1.2_linux_arm64.tar.gz"
      sha256 "004a951c5a042b147128db6465f38e17ff22cb788b0c6c15bc5c1236a5c0ccc7"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.2/memry_1.1.2_linux_amd64.tar.gz"
      sha256 "61e4b73a69de354d738b733057321e3a61f76e361fb607d4d6584c7a44f82b56"
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
