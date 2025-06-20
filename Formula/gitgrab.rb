# frozen_string_literal: true

PACKAGE = 'gitgrab'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
VERSION = '1.0.2'
HASHES = {
  darwin_amd64: 'c058f824aea5ec0c091cad7470b6d308c3c9585ada66639620bbf1a2fea0107b',
  darwin_arm64: '8566806a85e9ae0391173fe43a6b1e90089ba024ac54645356305beb33322ea7',
  linux_amd64:  'cc5ab86e3604479f9999cc8e3f6e33a214d15b914ce8dda0ea51512215cb5aad',
  linux_arm64:  'c7385b877286f6de0531d6825d032e667b353568b17ec3ec81e5f7359ca3e5cf',
}

# Homebrew formula
class Gitgrab < Formula
  desc 'CLI utility to clone all Github repositories in an organization.'
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
