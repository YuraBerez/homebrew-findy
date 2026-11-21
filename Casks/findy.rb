cask "findy" do
  arch arm: "Apple-Silicon", intel: "Intel"

  version "0.6.0"
  sha256 arm:   "66b467b869ad1cc607d60590809052771bb1ad53c12c39fdc13c98be6de8188b",
         intel: "845a4f32af8efd4c0a677811d94fb9f163cab9d87a2b9c9cb2e620853381f75d"

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
