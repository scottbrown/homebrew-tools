# frozen_string_literal: true

VERSION = "1.0.3"
PACKAGE = "hacksplaining-cli"
BINARY = "hacksplaining"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "9230b8edb76e33fd8888ae48bf8a9e661edf103f854883911aaf215a8011db0b",
  darwin_arm64: "d900a3716de04911ad708a0af4e5eae7e85be1dfc873a71b4d55d86101111b84",
  linux_amd64:  "c2258c9f16b6c8429753518dc3a281b84b89d68efa1405189dd4c8e1a8818355",
  linux_arm64:  "b7eb9987689d5d65aac6667a015672d7cc8bfc4fde53be5ffeb0b471d2d32d1e",
}.freeze

# Homebrew formula
class HacksplainingCli < Formula
  desc "CLI for Hacksplaining for ease of use by humans and AI"
  homepage "https://github.com/scottbrown/hacksplaining-cli"
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
