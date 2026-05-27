cask "vimac" do
  version "0.1.0"
  sha256 "6c91dcf9aba85a1e143acdabd83d39bfdf603c84034af856a59b2d3812fba270"

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
