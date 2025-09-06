# frozen_string_literal: true

PACKAGE = 'scruffy'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
VERSION = '0.0.0'
HASHES = {
  darwin_amd64: 'ba5cbbee1ecc253be0e09ff14eeec4a2d2fbe41a46e85b6f0d1c8578fbce7e01',
  darwin_arm64: '4c6acfac9e6b83ec69e6ff39ba719534507ced479196f17816d1f32fb27476e3',
  linux_amd64:  'adbe4946dec4b461e79c74400dff0c400708625f8afb77cf394987cc92a2ab4b',
  linux_arm64:  'cc88a8464118a3aecf9005860313cc660531e4cc52fb02acafe7df6ca054fa54',
}

# Homebrew formula
class Scruffy < Formula
  desc 'CLI app that cleans Cloudflare IP access rules'
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
