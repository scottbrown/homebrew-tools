# frozen_string_literal: true

VERSION = '2.0.1'
PACKAGE = 'setlist'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: 'ad4b7213c78aa627ef69f994180c796968e421a67f2fbbe48f0fa47d0698faf9',
  darwin_arm64: 'cc0d07127788fc3c75a7e1d2fc24dc2eba003117f9700c12d42a4cb787702098',
  linux_amd64: '6f0f63410f3bdae85ef9da41c2e08ff5b9595beb666b4046a7221dd066f8dfe0',
  linux_arm64: '4a8e44a557349867e6134d3ab98869839054d3824540b7625bc1f638d7186d9d',
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
