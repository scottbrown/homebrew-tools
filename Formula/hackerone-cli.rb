# frozen_string_literal: true

VERSION = '1.0.4'
PACKAGE = 'hackerone-cli'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: '3bee8f6392b71ecfa605c25dcc9303b6f3784ec375d2a6adc24e163ae20e4dae',
  darwin_arm64: '09c514b2f626bcc8e1d6babaa12dc08ce568b1e8d632c6e941b106d7745c04fb',
  linux_amd64: '3c0a926ef5b1f3d2891352b9d266c0c7ddf1be47f66393fa70310432084769e4',
  linux_arm64: '48168472a96593efd38ac829a16e2bc7187a08e82d57755947cea1bdd86020e5',
}

# Homebrew formula
class HackeroneCli < Formula
  desc 'CLI for accessing HackerOne'
  homepage REPO
  license 'MIT'
  version VERSION

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/h1_v#{VERSION}"
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
    bin.install h1
  end

  test do
    system "#{bin}/h1", '--help'
  end
end
