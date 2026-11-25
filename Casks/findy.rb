cask "findy" do
  arch arm: "Apple-Silicon", intel: "Intel"

  version "0.7.1"
  sha256 arm:   "32b19d225bd652dc29c1f0240cba84ddd2d3fcb144c0517a222cc2543ca785f0",
         intel: "c0c63c9dbeab80263f6eaf801fa80b4e8ae5b75e77a3471ca9d871b8348e7787"

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
