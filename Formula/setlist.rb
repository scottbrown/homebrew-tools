# frozen_string_literal: true

VERSION = '2.0.2'
PACKAGE = 'setlist'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: 'dd4ace386ca405a30a40665ba068855ebd194402cc1efaa9c3ac8501c2617025',
  darwin_arm64: '3366eb92e3f9b5455bedf3306fa7b7a31c9ba6593bed6c806cf34e13c8c8fdfc',
  linux_amd64: 'cdd1d11abeda2b8d72e897756adfe7f79c4f1be475738cea9fb2322d417284af',
  linux_arm64: '8dd2bd07cb6497ec41ab0d4472f222ce2eca0074bc23e2277503609e57d13060',
}

# Homebrew formula
class Setlist < Formula
  desc 'Command line tool to automatically generate a .aws/config file based on AWS SSO rules in your org.'
  homepage REPO
  license 'MIT'
  version VERSION

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
    system "#{bin}/#{PACKAGE}", '--help'
  end
end
