# frozen_string_literal: true

VERSION = '1.0.7'
PACKAGE = 'hackerone-cli'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: '8e0a67ba970a5e74a4f55e04a254785430523d89b5767ef9b5341864fe1c44e9',
  darwin_arm64: '9c262fa1e80d96299ab0008413ef4efd9655a3fa0949021d2a9312ecbd1f3081',
  linux_amd64: '004a7c1bcad4605a594364d1b25f550d867344b8d11f34809f28359593542d34',
  linux_arm64: '0b6809d72890b76f66486e1a49eb6933bf57efec6164c0ca4f876000640f9c1f',
}

# Homebrew formula
class HackeroneCli < Formula
  desc 'CLI for accessing HackerOne'
  homepage REPO
  license 'MIT'
  version VERSION

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/h1_v#{VERSION}"
  end

  on_macos do
    if Hardware::CPU.arm?
      url "#{prefix}_darwin_arm64.tar.gz"
      sha256 HASHES[:darwin_arm64]
    else
      url "#{prefix}_darwin_amd64.tar.gz"
      sha256 HASHES[:darwin_amd64]
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "#{prefix}_linux_arm64.tar.gz"
      sha256 HASHES[:linux_arm64]
    else
      url "#{prefix}_linux_amd64.tar.gz"
      sha256 HASHES[:linux_amd64]
    end
  end

  def install
    bin.install 'h1'
  end

  test do
    system "#{bin}/h1", '--help'
  end
end
