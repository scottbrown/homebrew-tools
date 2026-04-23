# frozen_string_literal: true

VERSION = '1.0.1'
PACKAGE = 'hacksplaining-cli'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: 'fc5d49e71ef65c6651a48b790fe4435fb3a6047e5189a9c471edb306ba90c8bb',
  darwin_arm64: '9aa732ac504b63d04c60f35abb328e1b832b5409b84c1a03cf8510c53339667e',
  linux_amd64: '1e62e16b5669e596d1593d07d58c29fd38c9aff08db9b7aaaa43a8691be3997f',
  linux_arm64: 'e6112747275b7fe4eda61d7b3425af30d33fd566d1da2aee279ba0ed7c8a8606',
}

# Homebrew formula
class HacksplainingCli < Formula
  desc 'LI for Hacksplaining for ease of use by humans and AI'
  homepage REPO
  license 'MIT'
  version VERSION

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/hacksplaining_v#{VERSION}"
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
    bin.install 'hacksplaining'
  end

  test do
    system "#{bin}/hacksplaining", '--help'
  end
end
