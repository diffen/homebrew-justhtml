# Homebrew Tap for justhtml

This tap provides the `justhtml` CLI via Homebrew.

`justhtml` is an HTML5 parser CLI with CSS selectors and full html5lib compliance.

## Install

Homebrew 6.0.0 (June 2026) requires third-party taps to be explicitly
trusted before their formulae can be loaded. Trust this tap, then install:

```sh
brew trust diffen/justhtml
brew install diffen/justhtml/justhtml
```

Trusting the tap means you accept that its code runs with your user's
privileges. This tap contains a single MIT-licensed formula
([Formula/justhtml.rb](Formula/justhtml.rb)) that installs the
MIT-licensed [justhtml-php](https://github.com/diffen/justhtml-php)
library — you can review both before trusting.

If you prefer to trust only this formula rather than the whole tap:

```sh
brew trust --formula diffen/justhtml/justhtml
brew install diffen/justhtml/justhtml
```

## Verify

```sh
justhtml --version
```

## CLI Documentation

The section below is synced from `diffen/justhtml-php/CLI.md`.
Commands are rewritten to use `justhtml` for Homebrew.

<!-- CLI_DOCS_START -->
# CLI

The `justhtml` CLI parses HTML, optionally selects nodes with a CSS selector, and outputs HTML, text, or Markdown.
It accepts either a file path or `-` for stdin.

Run it:

- From this repo: `justhtml`
- From a Composer install: `justhtml`

## Sample input used below

Create a small input file:

```sh
cat > sample.html <<'HTML'
<!doctype html>
<html>
  <body>
    <article id="post">
      <h1>Title</h1>
      <p class="lead">Hello <em>world</em>!</p>
      <p>Second <span>para</span>.</p>
    </article>
  </body>
</html>
HTML
```

Create a whitespace-focused file:

```sh
cat > whitespace.html <<'HTML'
<!doctype html>
<html><body>
  <p class="sep">Alpha<span>Beta</span>Gamma</p>
  <p class="ws">  Hello <span> world </span> ! </p>
</body></html>
HTML
```

## --selector

Select matching nodes (single selector):

```sh
justhtml sample.html --selector "p.lead" --format text
```

Output:

```text
Hello world!
```

Select multiple selectors with a comma-separated list:

```sh
justhtml sample.html --selector "h1, p.lead" --format text
```

Output:

```text
Title
Hello world!
```

## --format

Choose output format: `html`, `text`, or `markdown`.

HTML output:

```sh
justhtml sample.html --selector "p.lead" --format html
```

Output:

```html
<p class="lead">
  Hello
  <em>world</em>
  !
</p>
```

Text output:

```sh
justhtml sample.html --selector "p.lead" --format text
```

Output:

```text
Hello world!
```

Markdown output:

```sh
justhtml sample.html --selector "p.lead" --format markdown
```

Output:

```text
Hello *world*!
```

## --outer / --inner

HTML output uses outer HTML by default. Use `--inner` to print only the
matched node's children (inner HTML). `--outer` is a no-op that makes the
default explicit. These flags only affect `--format html`.

```sh
justhtml sample.html --selector "p.lead" --format html --inner
```

Output:

```html
Hello
<em>world</em>
!
```

## --attr / --missing

Extract attribute values from matched nodes. Repeat `--attr` to output multiple
attributes per node (tab-separated by default). Missing attributes are replaced
with `__MISSING__` by default; override with `--missing`.

```sh
justhtml sample.html --selector "p" --attr class --attr id
```

Output (tab-separated):

```text
lead	__MISSING__
__MISSING__	__MISSING__
```

Use `--separator` to change the field separator:

```sh
justhtml sample.html --selector "p" --attr class --attr id --separator ","
```

`--attr` cannot be combined with `--format`, `--inner`, `--outer`, or `--count`.

## --first

Limit to the first match:

```sh
justhtml sample.html --selector "p" --format text
```

Output:

```text
Hello world!
Second para.
```

```sh
justhtml sample.html --selector "p" --format text --first
```

Output:

```text
Hello world!
```

`--first` is equivalent to `--limit 1` and cannot be combined with `--limit`.

## --limit

Limit to the first N matches. This is equivalent to `--first` when N is 1.

```sh
justhtml sample.html --selector "p" --format text --limit 2
```

Output:

```text
Hello world!
Second para.
```

## --count

Print the number of matching nodes:

```sh
justhtml sample.html --selector "p" --count
```

Output:

```text
2
```

`--count` cannot be combined with `--first`, `--limit`, `--format`, or `--attr`.

## --separator

Join text nodes with a custom separator (text output only). In `--attr` mode,
this controls the field separator (default: tab).

```sh
justhtml whitespace.html --selector ".sep" --format text
```

Output:

```text
Alpha Beta Gamma
```

```sh
justhtml whitespace.html --selector ".sep" --format text --separator ""
```

Output:

```text
AlphaBetaGamma
```

## --strip / --no-strip

By default, each text node is trimmed and empty nodes are dropped (`--strip`).
Use `--no-strip` to preserve the original whitespace within text nodes.

Default (strip on):

```sh
justhtml whitespace.html --selector ".ws" --format text
```

Output:

```text
Hello world !
```

Preserve whitespace:

```sh
justhtml whitespace.html --selector ".ws" --format text --no-strip
```

Output (spaces shown between `|` markers):

```text
|  Hello   world   ! |
```

## Stdin

Read from stdin by passing `-` as the path:

```sh
cat sample.html | justhtml - --selector "p.lead" --format text
```

Output:

```text
Hello world!
```

## Piping examples (real pages)

These examples use a live page and pipe HTML into `justhtml`.

```sh
# Extract the first non-empty paragraph as text
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text p:not(:empty)" --format text --first

# Extract links from the lead section (first 10 hrefs)
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text p a" --attr href --limit 10 --separator "\n"

# Get the lead section as Markdown
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text" --format markdown --first

# Count images on the page
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "img" --count

# Output the infobox as HTML (outer HTML)
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "table.infobox" --format html --outer --first

# Preserve whitespace and separate paragraphs
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text p" --format text --no-strip --separator "\n\n" --limit 3

# Build a quick table of contents from headings
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text h2, #mw-content-text h3" --format text --separator "\n"
```

## --version and --help

```sh
justhtml --version
```

Output:

```text
justhtml dev
```

```sh
justhtml --help
```

Output: prints the full usage/help text.
<!-- CLI_DOCS_END -->

## Upgrading

```sh
brew upgrade justhtml
```

## Uninstall

```sh
brew uninstall justhtml
```

If you installed via the tap and want to remove it:

```sh
brew untap diffen/justhtml
brew untrust diffen/justhtml
```

## Troubleshooting

### “Refusing to load formula diffen/justhtml/justhtml from untrusted tap diffen/justhtml”

Homebrew 6.0.0 requires third-party taps to be explicitly trusted. If you
tapped `diffen/justhtml` before upgrading to Homebrew 6, any `brew`
command that touches this tap (`brew info justhtml`, `brew upgrade`, etc.)
will fail with this error until you trust it. Run one of:

```sh
# Trust the whole tap (covers future formula updates):
brew trust diffen/justhtml

# Or trust only this formula:
brew trust --formula diffen/justhtml/justhtml
```

This is a one-time step. You can review what you've trusted with
`brew trust` (no arguments) and revoke with `brew untrust diffen/justhtml`.
See the [Homebrew Tap Trust documentation](https://docs.brew.sh/Tap-Trust)
for details.

If you install via a Brewfile, declare the trust there:

```ruby
tap "diffen/justhtml", trusted: true
brew "diffen/justhtml/justhtml"
```

### “justhtml: command not found”

Make sure your Homebrew prefix is on `PATH`:

```sh
brew --prefix
```

Then ensure `$(brew --prefix)/bin` is on your `PATH`.

### Xdebug warning on `justhtml --version`

If you see an Xdebug warning from your PHP configuration, you can disable it for a single run:

```sh
XDEBUG_MODE=off justhtml --version
```

## Formula

The formula lives at:

- `Formula/justhtml.rb`

## License

MIT
