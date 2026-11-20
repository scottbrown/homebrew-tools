# frozen_string_literal: true

VERSION = "2.0.4"
PACKAGE = "setlist"
REPO = "https://github.com/scottbrown/#{PACKAGE}".freeze
HASHES = {
  darwin_amd64: "4461e9c7c24f0540f748027f6e6a00675cdec35d44c3f2984999814570cb1477",
  darwin_arm64: "8cad9c36651c8ef92c3ab78b581a868750ca0e25cb858abbf39c39d9b6fba110",
  linux_amd64:  "5ba3202e3e4029a5cb5329e1ee7868ad1016a867e248325a3decf793c7a380f4",
  linux_arm64:  "fa789a89fdec164db9e93750d6dedcc403cc50ebb15e9b5cc63ce0d76d4395d9",
}.freeze

# Homebrew formula
class Setlist < Formula
  desc "Generate .aws/config files based on AWS SSO rules"
  homepage "https://github.com/scottbrown/setlist"
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
