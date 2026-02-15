# frozen_string_literal: true

VERSION = '1.4.0'
PACKAGE = 'setlist'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: '7888a679c638d38ebcc1dd4c42ceea08e7485ba06bf85b1a808b7272c943f5aa',
  darwin_arm64: 'a5985a34ff7ee563b9b3217393bbecc716151b3c96abcf132cade3891039cfa0',
  linux_amd64: '7fd51ac317c29ebad99559a04295738a2c0cdb944bfc4a12dcc477289e23032f',
  linux_arm64: '4e95d4b5be12643c0bc2d66367394f9178ce67fdae42b690bf5ddad24cd2f676',
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
