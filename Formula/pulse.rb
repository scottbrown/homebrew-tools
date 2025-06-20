# frozen_string_literal: true

VERSION = '1.2.0'
PACKAGE = 'pulse'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: 'b0aa87f783fb9e0470502075bdd712851bc43054a96228c75a70dacf157c2b2c',
  darwin_arm64: '046c0aadddeccaf86c60508b68b201084f9af5aa60e61104873a3423755347ae',
  linux_amd64: 'bc5d2ee852e4c213a3b287f84e757099dfe15db3853c7afdfa3bed437b570fcf',
  linux_arm64: 'f5f29a98c6c0ba7988261f818f08d5fb3d46bbf5c23aba3c45d5a970705401bb',
}

# Homebrew formula
class Pulse < Formula
  desc 'A Risk and Performance measurement framework CLI application for organizational programs (e.g. Information Security, Legal).'
  homepage REPO
  license 'MIT'
  version VERSION

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/#{PACKAGE}"
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
