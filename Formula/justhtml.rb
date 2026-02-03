class Justhtml < Formula
  desc "HTML5 parser CLI with CSS selectors and full html5lib compliance"
  homepage "https://github.com/diffen/justhtml-php"
  url "https://github.com/diffen/justhtml-php/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "a61b3e229908285bbc7b6693787386b07741b234840b1506e01d97de5a641a68"
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
