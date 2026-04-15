class Dotfiles < Formula
  desc "Minimal, opinionated zsh environment: Starship prompt, Antidote plugins, fzf, zoxide"
  homepage "https://github.com/asakin/dotfiles"
  url "https://github.com/asakin/dotfiles/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "d73f7e3a45c99e048fb60a85a72785340321923e13f49826df1cef3f67e1673e"
  license "MIT"

  depends_on "starship"
  depends_on "zoxide"
  depends_on "fzf"

  def install
    bin.install "install.sh" => "dotfiles-install"
    bin.install "setup.sh"   => "dotfiles-setup"
    bin.install "uninstall.sh" => "dotfiles-uninstall"
    prefix.install "home"
  end

  def post_install
    # Install tools via setup script
    system "#{bin}/dotfiles-setup"
  end

  def caveats
    <<~EOS
      Symlink dotfiles into your home directory:
        dotfiles-install

      This will:
        - Clone the repo to ~/.config/dotfiles
        - Symlink .zshrc, .zsh_plugins.txt, and .config/starship.toml
        - Back up any existing files before replacing them

      To undo:
        dotfiles-uninstall

      Then reload your shell:
        source ~/.zshrc
    EOS
  end

  test do
    assert_predicate bin/"dotfiles-install", :exist?
  end
end
