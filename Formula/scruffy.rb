# frozen_string_literal: true

PACKAGE = "scruffy"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
VERSION = "0.0.1"
HASHES = {
  darwin_amd64: "5c7a0dd66bc89cb757d99f2d82a397b1563a86e07b0765d7bd6b0b611cd3ea14",
  darwin_arm64: "dc46ef2d9576fa06898bc696b3d90872a78ebd525bfbf5b66cecf6bc646e28ac",
  linux_amd64:  "147ec581dd8ed2a3a1dfd656ae4508959c1b95ced8d62e7f9046972547e1195c",
  linux_arm64:  "1cfb9ac7edf74b3715e012e3fc10396c74aa9fa4341dc5f303eab620557d0826",
}.freeze

# Homebrew formula
class Scruffy < Formula
  desc "CLI app that cleans Cloudflare IP access rules"
  homepage "https://github.com/scottbrown/scruffy"
  license "MIT"

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
    system "#{bin}/#{PACKAGE}", "--help"
  end
end
