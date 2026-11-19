cask "findy" do
  arch arm: "Apple-Silicon", intel: "Intel"

  version "0.4.0"
  sha256 arm:   "524585bf2cf6cfbdbac43a9d87f059c15de8364231b1767db0ce55dc212960c0",
         intel: "84f89061bc3bf4b2041d38b89f1b22f5de4440773a248e624dee58cf0418c8e3"

  url "https://github.com/YuraBerez/findy/releases/download/v#{version}/Findy-#{version}-macOS-#{arch}.dmg"
  name "Findy"
  desc "Private, local-first kanban board for a job search"
  homepage "https://github.com/YuraBerez/findy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Findy.app"

  zap trash: [
    "~/Library/Application Support/Findy",
    "~/Library/Logs/Findy",
    "~/Library/Preferences/io.github.findy.plist",
    "~/Library/Saved Application State/io.github.findy.savedState",
  ]

  caveats <<~EOS
    Findy is not signed with an Apple Developer ID yet, so macOS asks once:
      1. Open Findy. macOS says it cannot verify the app; click Done.
      2. Open System Settings > Privacy & Security and click "Open Anyway" next to Findy.
    After that, Findy opens normally. More: https://github.com/YuraBerez/findy#first-start-the-builds-are-not-signed-yet
  EOS
end
