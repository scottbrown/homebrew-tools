# frozen_string_literal: true

PACKAGE = 'uuid'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
VERSION = '1.0.4'
HASHES = {
  darwin_amd64: '77ff12e5a847398fead591ac14fd8c48818aa7aa04c9bb46223b56fdfe1f544e',
  darwin_arm64: '00e1ee9c8e6c6dafc38695f33c889da8fd6fe3b5577c5f866679befe579bad35',
  linux_amd64:  '5c5c66fb8d1d15304cf06d72eb519cbba18bacd4dc06b470ecac9120cbef12e0',
  linux_arm64:  '44ed3ea219cb3ed88390fd2c80d9407922d2b8f5224902f682c8c594ea21f3ef',
}

# Homebrew formula
class Uuid < Formula
  desc 'A lightweight, dependency-free Go CLI application for generating and parsing UUIDs. Supports multiple UUID versions with a focus on simplicity, performance, and standards compliance.'
  homepage REPO
  license 'MIT'
  version VERSION

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
    system "#{bin}/#{PACKAGE}", '--help'
  end
end
