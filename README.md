# Homebrew Tap for justhtml

This tap provides the `justhtml` CLI via Homebrew.

`justhtml` is an HTML5 parser CLI with CSS selectors and full html5lib compliance.

## Install

```sh
brew install diffen/justhtml/justhtml
```

## Verify

```sh
justhtml --version
```

## Usage Examples

```sh
# Extract the first non-empty paragraph as text (pipe-friendly)
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text p:not(:empty)" --format text --first

# Extract all links in the lead section (attribute extraction + limit + separator)
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text p a" --attr href --limit 10 --separator "\n"

# Get the lead section as markdown (selector + markdown output)
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text" --format markdown --first

# Count images on the page (count mode)
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "img" --count

# Output the outer HTML for the infobox (outer HTML)
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "table.infobox" --format html --outer --first

# Extract text without stripping whitespace (no-strip + custom separator)
curl -s https://en.wikipedia.org/wiki/Earth | \
  justhtml - --selector "#mw-content-text p" --format text --no-strip --separator "\n\n" --limit 3
```

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
```

## Troubleshooting

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
