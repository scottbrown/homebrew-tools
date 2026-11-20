# frozen_string_literal: true

VERSION = "2.0.3"
PACKAGE = "setlist"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "d3e2833a37736146703ebcde03c5f2e9e4bac812a3976d4b4d577051da8a66ce",
  darwin_arm64: "825f7e9f513ee56afde9f8c0562d522ad0328e52f467a106b94b88a9a6ad44ae",
  linux_amd64:  "5d115f83dda044b12c8cca2cccf4078a7e03eed7cca200e42440e3f134e469a9",
  linux_arm64:  "18d79e9d70bb24c46364594dcd7081970e5c2e6ea9aad6576bf6891215c121da",
}.freeze

# Homebrew formula
class Setlist < Formula
  desc "Generate .aws/config files based on AWS SSO rules"
  homepage "https://github.com/scottbrown/setlist"
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
