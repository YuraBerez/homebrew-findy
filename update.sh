#!/usr/bin/env bash
# Moves the cask to the latest *published* Findy release (no drafts, no pre-releases).
# Every download is checked against the release's SHA256SUMS.txt when it has one;
# any missing file or wrong sum stops the update and leaves the cask as it was.
set -euo pipefail

REPO="YuraBerez/findy"
CASK="Casks/findy.rb"

tag=$(gh api "repos/$REPO/releases/latest" --jq .tag_name)   # never a draft or pre-release
version="${tag#v}"
current=$(sed -nE 's/^  version "([^"]+)"/\1/p' "$CASK")
if [ "$version" = "$current" ]; then
  echo "Already at $version"
  exit 0
fi

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
names=("Findy-$version-macOS-Apple-Silicon.dmg" "Findy-$version-macOS-Intel.dmg")
for name in "${names[@]}"; do
  gh release download "$tag" --repo "$REPO" --pattern "$name" --dir "$work"
done
if gh release download "$tag" --repo "$REPO" --pattern SHA256SUMS.txt --dir "$work" 2>/dev/null; then
  (cd "$work" && grep -F -e "${names[0]}" -e "${names[1]}" SHA256SUMS.txt | shasum -a 256 -c -)
else
  echo "No SHA256SUMS.txt in $tag: using the sums of the downloads"
fi

arm=$(shasum -a 256 "$work/${names[0]}" | cut -d' ' -f1)
intel=$(shasum -a 256 "$work/${names[1]}" | cut -d' ' -f1)
sed -i.bak -E \
  -e "s/^  version \"[^\"]+\"/  version \"$version\"/" \
  -e "s/^  sha256 arm:   \"[0-9a-f]+\",/  sha256 arm:   \"$arm\",/" \
  -e "s/^         intel: \"[0-9a-f]+\"/         intel: \"$intel\"/" \
  "$CASK"
rm -f "$CASK.bak"
grep -q "$arm" "$CASK" && grep -q "$intel" "$CASK" || { echo "Cask not updated"; exit 1; }
echo "Updated to $version"
