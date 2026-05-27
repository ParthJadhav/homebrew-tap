# ParthJadhav's Homebrew Tap

Formulas for tools I maintain.

## Install

```bash
brew tap ParthJadhav/tap
```

Then install any formula:

```bash
brew install ParthJadhav/tap/cmdq
```

Private-source formulae may require GitHub credentials:

```bash
gh auth login
gh auth setup-git
```

Formulae that support optional URL downloads may need extra tools. For example, install `yt-dlp` if you want `vid-cli --song` to accept YouTube/video URLs.

## Available formulas

- [`cmdq`](https://github.com/ParthJadhav/cmdq) — type the next command while one is still running
- [`vid-cli`](https://github.com/ParthJadhav/vid-cli) — create short reels from folders of images and videos
