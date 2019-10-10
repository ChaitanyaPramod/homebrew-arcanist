class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2018-02-15/1.tar.gz"
    sha256 "75888393e3f0ffb8a567a877b31903db8390b622f73ad501b8eb1bcafb4320fa"
    version "201802151"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2018-02-15/1.tar.gz"
      sha256 "a46f0721fa8166ed5edf24ecfe395d7d41e4728681969dded12c664c6fb2074e"
      version "201802151"
    end
  end
 end

  head do
    url "https://github.com/phacility/arcanist.git"

    resource "libphutil" do
      url "https://github.com/phacility/libphutil.git"
    end
  end

  def install
    libexec.install Dir["*"]

    resource("libphutil").stage do
      (buildpath/"libphutil").install Dir["*"]
    end

    prefix.install Dir["*"]

    bin.install_symlink libexec/"bin/arc" => "arc"

    cp libexec/"resources/shell/bash-completion", libexec/"resources/shell/arc-completion.zsh"
    bash_completion.install libexec/"resources/shell/bash-completion" => "arc"
    zsh_completion.install libexec/"resources/shell/arc-completion.zsh" => "_arc"
  end

  test do
    system "#{bin}/arc", "help"
  end
end

