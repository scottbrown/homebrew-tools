# frozen_string_literal: true

VERSION = "0.1.1"
PACKAGE = "socket-cli"
BINARY = "socket"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "3ce979116654e8001ef67e631d3a65b99c39f8fa2fa78f40a9c4cc0343ecec98",
  darwin_arm64: "1401e01f480c3b267b69d1bca21dfdbb78d96470d837f1f97f272bc20f450cce",
  linux_amd64:  "ab1c5f0757e56b97802de080d344b9da9c09cf243f200f8f64eafc68232a5242",
  linux_arm64:  "1170103230507606db1fb7d163fc9c4bf18492f24e48fb996bbb48649d427709",
}.freeze

# Homebrew formula
class SocketCli < Formula
  desc "CLI for accessing Socket"
  homepage "https://github.com/scottbrown/socket-cli"
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
