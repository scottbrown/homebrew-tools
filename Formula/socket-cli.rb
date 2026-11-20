# frozen_string_literal: true

VERSION = "0.1.2"
PACKAGE = "socket-cli"
BINARY = "socket"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "280ca289bf5fe07741877d979ae6532f839bc91afe67c13ad7f6efd320d337c3",
  darwin_arm64: "a62ddae64d66470e06685b172471e890ca29a29af0b19a847adcbca6aaf90ac0",
  linux_amd64:  "bcdb661b07ccf1e43b7be12b98022dadc7dcb81f6ceb97671355c1728d451155",
  linux_arm64:  "57f1c8aa8e9d18b7d271bdb94e073f1f317836b15624724186d3107d99b05fc4",
}.freeze

# Homebrew formula
class SocketCli < Formula
  desc "CLI for accessing Socket"
  homepage "https://github.com/scottbrown/socket-cli"
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
