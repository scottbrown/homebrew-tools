# frozen_string_literal: true

VERSION = "1.0.10"
PACKAGE = "hackerone-cli"
BINARY = "h1"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "795249574ba279b337a53f1d1064726d974d66bd50d2a669338cfcef1ebedbfd",
  darwin_arm64: "08ea296e21b512f5da534e1771590d5c9648369d3965a9130aab2c44912124e7",
  linux_amd64:  "d3a97285ba5139f56df345d192c5e624de48f44643190b5f78c515769cfdc076",
  linux_arm64:  "67c4b036925b1f8ab03f3d9687cfffec7ffea203e5663e2f55f96e887a3d0c7a",
}.freeze

# Homebrew formula
class HackeroneCli < Formula
  desc "CLI for accessing HackerOne"
  homepage "https://github.com/scottbrown/hackerone-cli"
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
