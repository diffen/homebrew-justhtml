# Homebrew Tap for justhtml

This tap provides the `justhtml` CLI via Homebrew.

`justhtml` is an HTML5 parser CLI with CSS selectors and full html5lib compliance.

## Install

### Option 1: One-liner

```sh
brew install diffen/justhtml/justhtml
```

### Option 2: Tap first (shorter install command)

```sh
brew tap diffen/justhtml
brew install justhtml
```

## Verify

```sh
justhtml --version
```

## Basic usage

```sh
# Extract text from a selector
justhtml page.html --selector "main p" --format text

# Read from stdin (pipe friendly)
curl -s https://example.com | justhtml - --selector "article" --format markdown

# Extract attribute values
justhtml page.html --selector "a" --attr href
```

## Requirements

- Homebrew
- PHP (installed automatically by Homebrew as a dependency)

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
