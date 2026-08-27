# frozen_string_literal: true

VERSION = "1.0.0"
PACKAGE = "dependabot-pr-checker"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "608bc0fb0a3a02914e19594755d12c5dec53fa7a8c671dbd2cc7498bc7497994",
  darwin_arm64: "22bd283dbfd3caf777d2569243b564d59e957ffd8a174b0b388e6dfa1d0e1ec2",
  linux_amd64:  "0e49a99c879e21917a2848d83a5f64eaf07f0706c30153022d51440fe029a7de",
  linux_arm64:  "75529c47cbf81e75e1ccf893d0e240103fb5cab04cd65cd0edb3ac0b63ff90e0",
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
