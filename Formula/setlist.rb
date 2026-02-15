# frozen_string_literal: true

VERSION = '2.0.0'
PACKAGE = 'setlist'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: '58337beaf74f898b8f5fdeb57ea312fe7c5801e71d895525dde0a8dedccb9ead',
  darwin_arm64: 'd29b611880dc48183ecc6505f0f443be190a67b48af24aac58aa911ec2d05d47',
  linux_amd64: '45c80d9bf76fbf8827fad9bed46a33981f033a7df2abe306f5d6df723bfb1e57',
  linux_arm64: '8f0528c7e104201697435991c6d2d8c6972494ba36f47f63ae29129594e4a2fc',
}

# Homebrew formula
class Setlist < Formula
  desc 'Command line tool to automatically generate a .aws/config file based on AWS SSO rules in your org.'
  homepage REPO
  license 'MIT'
  version VERSION

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/#{PACKAGE}_#{VERSION}"
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
    system "#{bin}/#{PACKAGE}", '--help'
  end
end
