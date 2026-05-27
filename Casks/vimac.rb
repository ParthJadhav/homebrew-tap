cask "vimac" do
  version "0.1.0"
  sha256 "03ad84fc7cbaca0282cf47dd2baf014974e88f945e477b184589ee65869148ff"

  url "https://github.com/ParthJadhav/vimac-modern/releases/download/v#{version}/Vimac-#{version}.zip",
      verified: "github.com/ParthJadhav/vimac-modern/"
  name "Vimac"
  desc "Keyboard-driven macOS app navigation"
  homepage "https://github.com/ParthJadhav/vimac-modern"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sequoia"

  app "Vimac.app"

  zap trash: [
    "~/Library/Application Support/dev.vimac.Vimac",
    "~/Library/Caches/dev.vimac.Vimac",
    "~/Library/Preferences/dev.vimac.Vimac.plist",
  ]
end
