require 'formula'

class SysopsBootstrap < Formula
  homepage 'http://typicalrunt.me'
  version '1.0.0'

  # We need a dummy URL, something that won't change often
  url 'https://github.com/Homebrew/homebrew/blob/master/LICENSE.txt'
  sha256 'b81a43c06b6936ccb55cf331f5856568cb15f4895134c3fdb137ed1fea2f7bc6'

  depends_on 'rbenv'
  depends_on 'ruby-build'
  depends_on 'pyenv'
  depends_on 'go'

  depends_on 'shellcheck'

  depends_on 'tmux'
  depends_on 'wget'
  depends_on 'git'
  depends_on 'parallel'
  depends_on 'jq'

  depends_on 'packer'
  depends_on 'terraform'

  def caveats
    caveat = <<-HEREDOC.undent
      Welcome to SysOps.

      Our goal is to automate ALL THE THINGS.

      Please enjoy your stay.
    HEREDOC

    caveat
  end

  def install
    # install the latest stable version of Ruby
    system 'rbenv install --skip-existing 2.2.2'
    # install the latest stable version of Python
    system 'pyenv install --skip-existing 3.4.3'
  end

  test do
    system 'terraform --help'
    system 'packer --help'
  end
end

