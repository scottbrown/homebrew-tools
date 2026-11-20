# frozen_string_literal: true

VERSION = "3.0.1"
PACKAGE = "dependabot-pr-checker"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "e35cc60f76cf1956cee2f5a7c6f4130863697cbde3e3aae5d3b6124a8e12de48",
  darwin_arm64: "e7f426af39d23e78c7e9565c20aeb63846a4455f84c67902b8a25ad98fc832e8",
  linux_amd64:  "012a4285df03e2a145dcd30685e112d4de2516e6162755476cc9af210caeb3e4",
  linux_arm64:  "a6ab74c7dde905a777d31ac48612bf7dd206460fbb5234f375675a151de4ff32",
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
