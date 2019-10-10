class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  depends_on "php"
  depends_on "git"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2019-08-22/1.tar.gz"
    sha256 "6a5f726870224da8cf18d904bb96a1a6d8ee25d31c27ff8a0d2093884c243887"
    version "201908221"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2019-08-22/1.tar.gz"
      sha256 "5fc22b2870048b99018474212845b9c03205cab64e5b3f1c20dd72d802fc6df2"
      version "201908221"
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

