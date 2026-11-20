cask "findy" do
  arch arm: "Apple-Silicon", intel: "Intel"

  version "0.5.0"
  sha256 arm:   "4f3552a43999e9aa048586e9df9248f9d98617a71ea92d7646256339510caf30",
         intel: "cbf223143e14be6d516af9f1b6a35274356afe1946f4697b82b3ea8114cca7df"

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
