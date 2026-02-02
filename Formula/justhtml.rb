class Justhtml < Formula
  desc "HTML5 parser CLI with CSS selectors and full html5lib compliance"
  homepage "https://github.com/diffen/justhtml-php"
  url "https://github.com/diffen/justhtml-php/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "390a695b12553f2c2283f4ab195fc29e060dee1d8798ef93277e484889d966aa"
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
