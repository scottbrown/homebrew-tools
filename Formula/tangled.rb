# frozen_string_literal: true

PACKAGE = "tangled"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
VERSION = "0.0.2"
HASHES = {
  darwin_amd64: "d18876216f1a9e8b62dc8575566a2d9bcfb211c1f639ba8ace56ded0465bdb86",
  darwin_arm64: "2699f1b6c218b43f73a2d1dbe44c56a14bd5a931a98c90555a4cd93ef29c796e",
  linux_amd64:  "8bd9049b0a7ec1624c1e84daee95c8db5b95f901ec75ddd29f1bfaeae3914867",
  linux_arm64:  "ceed79627a8b7dbc8c66d04a0db85ee47b1bde6e65feaa05e428f05b54908ea8",
}.freeze

# Homebrew formula
class Tangled < Formula
  desc "Visualize Go dependency relationships"
  homepage "https://github.com/scottbrown/tangled"
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
