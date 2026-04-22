# frozen_string_literal: true

VERSION = '1.0.8'
PACKAGE = 'hackerone-cli'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: 'f87e8dd1e2c476a4a88ba128865cd82fd2c029666df087a8b388bb5fb76fd130',
  darwin_arm64: 'ea74c47732115477fa53f6aa3555fa48f0fb8c9fd68f5f5cd44a5f9ba052aa84',
  linux_amd64: 'cfb78c89867dc0cf32345c2f39f4cafb6b92838a4093d87aea24a127aadb6d40',
  linux_arm64: '7f5fd3e411a54d08d80539b1b465c0832273e4f79ca37eab1c3d5217b04b3650',
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
