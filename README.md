# OpenMoat Homebrew tap

Homebrew formulae for [OpenMoat](https://github.com/crocodile-labs/openmoat), security for AI
coding agents by Crocodile Labs. The command it installs is `openmoat`; `moat`, its name up to
0.7.0, is installed beside it for a few releases.

```bash
brew install crocodile-labs/tap/openmoat
```

The formula was called `moat` up to 0.7.0. `formula_renames.json` points the old name at the
new one, so `brew upgrade` moves an existing install across.

[OpenMoat Bar](https://github.com/crocodile-labs/openmoat-bar), the menu bar app for macOS:

```bash
brew install --cask crocodile-labs/tap/openmoat-bar
```

The release workflow of `crocodile-labs/openmoat` writes the formulae in `Formula/` on every
tagged release, so do not edit them by hand. `Casks/openmoat-bar.rb` is updated for each
OpenMoat Bar release. Report problems in the
[OpenMoat issue tracker](https://github.com/crocodile-labs/openmoat/issues).
