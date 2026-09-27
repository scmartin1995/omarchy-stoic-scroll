# Stoic Scroll for Omarchy

An Omarchy Quattro bar widget that scrolls Stoic quotes across the bar, one at a
time, like a news ticker.

![Stoic Scroll in the Omarchy bar](preview.png)

## Features

- 53 quotes from Marcus Aurelius, Epictetus, and Seneca, each taken verbatim from
  a public-domain translation (see [SOURCES.md](SOURCES.md))
- Sizes itself to the free space between the center modules and the edge of the
  bar, so it never covers the clock, weather, or other center widgets; hides
  itself when there is less than 80px to spare
- Hover to pause and see the full quote with its source (book or letter)
- Click to skip to another quote
- Fully offline: no network requests, accounts, packages, background
  processes, or install hooks

## Install

Omarchy plugins run as unsandboxed code inside `omarchy-shell`. Review this
repository, then install and enable it:

```bash
omarchy plugin add https://github.com/scmartin1995/omarchy-stoic-scroll.git --enable
```

The widget starts in the right section of the bar. To move it:

```bash
omarchy bar move io.github.scmartin1995.stoic-scroll --section right --index 0
```

It is designed for the left or right section, where it measures the gap next to
the center modules. In the center section it uses its maximum width.

## Settings

Set these on the widget's entry in `~/.config/omarchy/shell.json`:

| Key | Default | Meaning |
|---|---|---|
| `maxWidth` | `600` | Upper limit on width in pixels; the widget uses less when space is tight |
| `speed` | `40` | Scroll speed in pixels per second |

```bash
omarchy bar set io.github.scmartin1995.stoic-scroll speed 30 --json
```

## Update

```bash
omarchy plugin update io.github.scmartin1995.stoic-scroll
omarchy restart shell
```

Restart the shell after updating; hot reload can keep the previous version of
the widget running.

## Remove

```bash
omarchy plugin remove io.github.scmartin1995.stoic-scroll
```

This removes the widget from the bar and deletes the plugin directory.

## Dependencies

None at runtime beyond Omarchy Quattro's shell. Python 3 is only needed by
maintainers running `scripts/verify-quotes.py`.

## License

Code is MIT licensed (see [LICENSE](LICENSE)). The quotations are excerpts from
public-domain translations listed in [SOURCES.md](SOURCES.md).
