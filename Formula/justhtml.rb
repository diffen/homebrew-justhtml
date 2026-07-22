class Justhtml < Formula
  desc "HTML5 parser CLI with CSS selectors and full html5lib compliance"
  homepage "https://github.com/diffen/justhtml-php"
  url "https://github.com/diffen/justhtml-php/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "6e658ab5061140c8f6efe018597ff0569380c54acb0206d542587772608662ab"
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
