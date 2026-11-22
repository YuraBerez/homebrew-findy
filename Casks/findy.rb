cask "findy" do
  arch arm: "Apple-Silicon", intel: "Intel"

  version "0.6.1"
  sha256 arm:   "24f88b05f3f506ee9856568c70fc5cdf62cad5f7b94b7a8d78cfb1a17f2fc984",
         intel: "4431b4540668b3d10d3291971d94682c1a9350363d74b5054e2740e22fa8e589"

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
