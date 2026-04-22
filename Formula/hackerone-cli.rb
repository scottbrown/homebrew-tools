# frozen_string_literal: true

VERSION = '1.0.6'
PACKAGE = 'hackerone-cli'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: '86f57e4a63ced28300f5682a944f8a527d6053869981c1161291d13bf313e004',
  darwin_arm64: '4cebe51f7ed8fda8bb6a22c17e5c32826dade47f9d61129c113f6b4da9d12345',
  linux_amd64: '150b8a3ab9144bd8c85e7f1102cb08c480f1158ffa430c0108e325323ad959d0',
  linux_arm64: '22ac6ee1ccb52efe7fd57144261fea42104780c1263ac409c0a01e47f1ade9c0',
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
    bin.install 'h1'
  end

  test do
    system "#{bin}/h1", '--help'
  end
end
