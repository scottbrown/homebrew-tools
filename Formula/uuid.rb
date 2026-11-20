# frozen_string_literal: true

PACKAGE = "uuid"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
VERSION = "1.0.5"
HASHES = {
  darwin_amd64: "89aede7e339c6a898d29efd0d25da67d85e88e005cdfd812fdee4c581fbf7e8a",
  darwin_arm64: "735b159cc6c0e3f2185a9bf21da845b4f431f49f7e63ad0e95dd22dd436f6cc4",
  linux_amd64:  "fef8364e7890f91d51e8fc2be5fd17700a7f722fb12d85d9cb12114706394090",
  linux_arm64:  "fb3189a3e827166e6ec1537e19be4bb1a6d4efd1a54f2950fa89f5a47aaf3667",
}.freeze

# Homebrew formula
class Uuid < Formula
  desc "Generate and parse UUIDs from the command-line"
  homepage "https://github.com/scottbrown/uuid"
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
