class Memry < Formula
  desc "Log in to memry and wire its memory MCP into your AI agents"
  homepage "https://github.com/mrtheroi/memry-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.1/memry_1.1.1_darwin_arm64.tar.gz"
      sha256 "bac0323c2e617245b51f7a85062663d792c10a88f053b0acaaaeb1b470ac5e1a"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.1/memry_1.1.1_darwin_amd64.tar.gz"
      sha256 "ca6d13c206eedb9feb8ba0ec7c4abaa3a9f6b142328dac1dffaf5e140c569ad4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.1/memry_1.1.1_linux_arm64.tar.gz"
      sha256 "25a57705630213f38f5731a2c5b3b72baf87f079a0c0226b4310dc71412e50c7"
    end
    on_intel do
      url "https://github.com/mrtheroi/memry-cli/releases/download/v1.1.1/memry_1.1.1_linux_amd64.tar.gz"
      sha256 "949daa9a2f1d72c5a7e6cf26093d3c528b4ce18c10c7eafd9edde0cf0102bc87"
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
