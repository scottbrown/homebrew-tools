# frozen_string_literal: true

PACKAGE = 'tangled'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
VERSION = '0.0.1'
HASHES = {
  darwin_amd64: '5719bc937165a64fb54b12884bb9f2f6d64700f600b031f74c3c9483652d2a76',
  darwin_arm64: '583247a90621a6ec9dece881d9dedd905ab55851fd6fdba27a42cd1d47f3fae0',
  linux_amd64:  'c57fc6da909cb0799956630bb4b33d0c20e0ca25214b8c397a5b26ba75598ef5',
  linux_arm64:  '3d974931650885a92c2b8e311582f992bf6344950656a270710d081c8f31d511',
}

# Homebrew formula
class Tangled < Formula
  desc 'A way to visualize Go dependency relationships'
  homepage REPO
  license 'MIT'
  version VERSION

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/#{PACKAGE}-v#{VERSION}"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "#{prefix}-darwin-arm64.tar.gz"
      sha256 HASHES[:darwin_arm64]
    else
      url "#{prefix}-darwin-amd64.tar.gz"
      sha256 HASHES[:darwin_amd64]
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{prefix}-linux-arm64.tar.gz"
      sha256 HASHES[:linux_arm64]
    else
      url "#{prefix}-linux-amd64.tar.gz"
      sha256 HASHES[:linux_amd64]
    end
  end

  def install
    bin.install PACKAGE
  end

  test do
    system "#{bin}/#{PACKAGE}", '--help'
  end
end
