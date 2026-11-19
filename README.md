# Homebrew tap for Findy

[Findy](https://github.com/YuraBerez/findy) is a private, local-first kanban board for a
job search. This tap installs it on macOS (Apple Silicon and Intel).

```sh
brew tap yuraberez/findy
brew trust yuraberez/findy
brew install --cask findy
```

`brew trust` is needed once: Homebrew loads casks from taps outside its own catalogue
only after you trust them.

Update with `brew upgrade --cask findy`. `brew uninstall --cask findy` keeps your
board; `brew uninstall --zap --cask findy` removes it too.

## First start

Findy is not signed with an Apple Developer ID yet. The first time you open it, macOS
cannot verify it: open **System Settings → Privacy & Security** and click **Open
Anyway** next to Findy. You do this once. This tap does not remove the macOS
quarantine for you.

## How the cask is updated

[`update.sh`](update.sh) runs every day ([workflow](.github/workflows/update.yml)). It
reads the latest **published** release of Findy, downloads both `.dmg` files, checks
them against the release's `SHA256SUMS.txt`, and commits the new version and sums. A
missing file or a wrong sum stops the update.

To check a download yourself:
`gh attestation verify Findy-<version>-macOS-Apple-Silicon.dmg --repo YuraBerez/findy`.
