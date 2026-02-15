# frozen_string_literal: true

VERSION = '1.3.0'
PACKAGE = 'setlist'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: '988a99dcd18f148de22bb7ed6c9e0b148d3a7f9448a5b28eb1a7582448598780',
  darwin_arm64: 'db4f0ac041098ddac5ecd3ef455e9d9e97b9457fa04f78a1c6214b5a17ed758d',
  linux_amd64: '6a158555be6e55b069f771c510d702b3afd866ac1def02598a58faee18c566f7',
  linux_arm64: '9fee9a98c550e8e8d7aa0fb1af458063799e29faa1769968b44a8906cfc582fd',
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
