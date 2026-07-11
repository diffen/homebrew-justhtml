class Justhtml < Formula
  desc "HTML5 parser CLI with CSS selectors and full html5lib compliance"
  homepage "https://github.com/diffen/justhtml-php"
  url "https://github.com/diffen/justhtml-php/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "0674f3d103b6491b046b8ac4a0ed578da5c36dbb573e7d96d4fe043e244cadfc"
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
