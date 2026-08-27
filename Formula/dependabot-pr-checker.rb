# frozen_string_literal: true

VERSION = "2.0.1"
PACKAGE = "dependabot-pr-checker"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "3ae74c1b9e7e60b3c44eeba0b780b97450eb11b4c16614c634ee659e9b4fd91d",
  darwin_arm64: "e81d88b806cd55bedb61c58152a56615368299e9c49be9b22797d631d6f26614",
  linux_amd64:  "aecb69f83f0f8fe98384196e293b8abf58786e3c73a20ec5a82f329448ac1788",
  linux_arm64:  "ab7c4dbaa46c01291ff827f0709a98e22d819bc914c4f0324d3d1a45bc0b007b",
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
