# frozen_string_literal: true

VERSION = "1.0.11"
PACKAGE = "hackerone-cli"
BINARY = "h1"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "0faef8ca6a2e902a55fc369d2555edf209721ab8a21100de27c377d1ab8a1cf6",
  darwin_arm64: "78b1aad678ebc945bcd0bc64c45cd8f289464c459cf134b5a3545a770cbc8231",
  linux_amd64:  "74447588f1ee67ffdb4da06a3b5556f6c2611d72027ff0900471e0df63520d83",
  linux_arm64:  "7ef24b4a9fed00d77d6f83df96a2b6eb83518d1208a096f1012811d8c6d64564",
}.freeze

# Homebrew formula
class HackeroneCli < Formula
  desc "CLI for accessing HackerOne"
  homepage "https://github.com/scottbrown/hackerone-cli"
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
