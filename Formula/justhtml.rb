class Justhtml < Formula
  desc "HTML5 parser CLI with CSS selectors and full html5lib compliance"
  homepage "https://github.com/diffen/justhtml-php"
  url "https://github.com/diffen/justhtml-php/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "26a46b540c39aca2305f955ec8194b3b83013a61ad78cf561e913967a7ce4020"
  license "MIT"

  depends_on "php"

  def install
    prefix.install "src", "data", "VERSION"
    bin.install "bin/justhtml"
  end

  test do
    (testpath/"sample.html").write "<main><p>Hello</p></main>"
    assert_equal "Hello",
                 shell_output("#{bin}/justhtml sample.html --selector p --format text").strip
  end
end
