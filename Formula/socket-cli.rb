# frozen_string_literal: true

VERSION = "0.1.0"
PACKAGE = "socket-cli"
BINARY = "socket"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "26409c32d335934e9051daa180ef71d1513d6885fd848b300a1161f3a60a63d8",
  darwin_arm64: "55b5785f5fe7a64590092868ca15a0e8b498a7273683e7bb126a19b7cdf27592",
  linux_amd64:  "cb902478ec951f8b93d0ae5c3ee578c42054db4c1a1fa745546a627eed1f3018",
  linux_arm64:  "56f2784e80cff11ec1af6dee274b8d8db5f02cceffbc929add26aac70ec69bab",
}.freeze

# Homebrew formula
class SocketCli < Formula
  desc "CLI for accessing Socket"
  homepage REPO
  version VERSION
  license "MIT"

  def self.prefix
    "#{REPO}/releases/download/v#{VERSION}/#{BINARY}_v#{VERSION}"
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
    bin.install BINARY
  end

  test do
    system "#{bin}/#{BINARY}", "--help"
  end
end
