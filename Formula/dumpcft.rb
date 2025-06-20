# frozen_string_literal: true

VERSION = '1.0.0'
PACKAGE = 'dumpcft'
REPO = "https://github.com/scottbrown/#{PACKAGE}"
HASHES = {
  darwin_amd64: '997031e9249cde1d9240ea2837d5a92a39cf9e03bfa64dbe02b3f0dc5403c61f',
  darwin_arm64: 'e6198672c41430df212221a60c24cdf64d9aaa013a4cbac8a539200e55a64d5f',
  linux_amd64: '3633c9dbc771a012abd0a1a559c699a65a86d514ffa722d8428e022cdea528cb',
  linux_arm64: '1e9412705e6ce1622c2c6bfd886d7376b8c55be374fb6c62f04ae02e6dd04f5d',
}

# Homebrew formula
class Dumpcft < Formula
  desc 'Dumps the templates of all CloudFormation stacks in one or more regions.'
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
