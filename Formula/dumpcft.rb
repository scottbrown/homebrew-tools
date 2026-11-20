# frozen_string_literal: true

VERSION = "1.0.1"
PACKAGE = "dumpcft"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "a1edb9133cf425a1871017dc0fd2a3f68840cb3a5bc3ac98d43100baf45b10ae",
  darwin_arm64: "63a2055b63aea4751365d663e7a3751fa5a260a305a803d39884335323e78cb6",
  linux_amd64:  "2669c9a2fd43ffd90a048aacf277f28b8113fc9ca8d456105b41a04000d03f64",
  linux_arm64:  "b45237fb203c20f7a0957f7c9a9909297743c6b2f275ef13d0f5c291b7688058",
}.freeze

# Homebrew formula
class Dumpcft < Formula
  desc "Dumps the templates of all CloudFormation stacks in one or more regions"
  homepage "https://github.com/scottbrown/dumpcft"
  license "MIT"

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
    system "#{bin}/#{PACKAGE}", "--help"
  end
end
