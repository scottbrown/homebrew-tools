# frozen_string_literal: true

PACKAGE = "gitgrab"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
VERSION = "1.0.3"
HASHES = {
  darwin_amd64: "f87c7c4ed710a407741fb987194af155d88730bf334e9f553887ab7b2c5c80a0",
  darwin_arm64: "d5f90cadc71d896c0fed80180915627aea09a474a220eebf83d46dfbcfa53994",
  linux_amd64:  "9a73e4df031f2d9c7c8362bc7a526ce4417342ec9fe289ffe4e3cdadab240aaf",
  linux_arm64:  "35e84d556291cccbf4471f38b18106b1e22754b343e53d8288e5c972645bf360",
}.freeze

# Homebrew formula
class Gitgrab < Formula
  desc "CLI utility to clone all Github repositories in an organization"
  homepage "https://github.com/scottbrown/gitgrab"
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
