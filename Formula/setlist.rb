# frozen_string_literal: true

VERSION = '1.2.1'
PACKAGE = 'setlist'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: '80b95fc848fab691951bed6232201b49c5c08f2aaae876972bbcd8eb0b816561',
  darwin_arm64: '45fa14e559f798caf5b9da7b2da0100c42f04baed49303957a228e4a330b41fe',
  linux_amd64: '224febba42434890c2f320cca9f4f8ebc4fa56a2291a174dced94cdbe5436850',
  linux_arm64: '2ce64b67eb433a24376e9cd0e8214713bf32e26a50603132768e78e55fce9650',
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
