# frozen_string_literal: true

VERSION = "1.0.2"
PACKAGE = "hacksplaining-cli"
BINARY = "hacksplaining"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "0783296b596f393732f1e0a08835d5a48aea2febc77ef1289e0eeb051d3444d2",
  darwin_arm64: "76e1b44c53d4462265534f97bf76f348888ecc7ff7442552449a1a45a7f058be",
  linux_amd64:  "a61d93e5e2669212339e655c404a52941336dacda085b44ef9a5b0c0c32cc270",
  linux_arm64:  "7f30b352f24754d457a99cb38668d1b2f0fa5d692e228489793e21d9d486170e",
}.freeze

# Homebrew formula
class HacksplainingCli < Formula
  desc "CLI for Hacksplaining for ease of use by humans and AI"
  homepage "https://github.com/scottbrown/hacksplaining-cli"
  version VERSION
  license "MIT"

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/#{BINARY}_v#{VERSION}"
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
    bin.install BINARY
  end

  test do
    system "#{bin}/#{BINARY}", "--help"
  end
end
