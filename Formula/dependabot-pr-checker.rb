# frozen_string_literal: true

VERSION = "3.0.0"
PACKAGE = "dependabot-pr-checker"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "b8231153bfcda7cda5b318b06fe995f0aeba151eca999711704f39ba74ad4e4d",
  darwin_arm64: "4443038d63d7f924bd0f50564d1fde3da1b77a5bbe711b6f4c4fd4aca3aa0318",
  linux_amd64:  "4d4e2ed6ec276d8ebe6aa3b32e5fa8f7f96d1ddc4f660723ac3d963825cce0a2",
  linux_arm64:  "9ab4e19bdd95a24a089f39f3aecc220fa796316978606c9beb5400d071110668",
}.freeze

# Homebrew formula
class DependabotPrChecker < Formula
  desc "Retrieves metrics on stale Dependabot PRs across a Github organization"
  homepage "https://github.com/scottbrown/dependabot-pr-checker"
  license "MIT"

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/#{PACKAGE}_v#{VERSION}"
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
    bin.install PACKAGE
  end

  test do
    system "#{bin}/#{PACKAGE}", "--help"
  end
end
