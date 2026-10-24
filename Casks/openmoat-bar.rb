cask "openmoat-bar" do
  version "0.3.0"
  sha256 "4bb90cf4e80fa50afcd95a77e1372e0fccd5d616df976c5ed807d6d602c107b9"

  url "https://github.com/crocodile-labs/openmoat-bar/releases/download/v#{version}/openmoat-bar-macos.zip"
  name "OpenMoat Bar"
  desc "Menu bar app that shows what OpenMoat decides for your coding agents"
  homepage "https://github.com/crocodile-labs/openmoat-bar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "OpenMoat Bar.app"

  zap trash: "~/Library/Preferences/dev.openmoat.bar.plist"

  caveats <<~EOS
    OpenMoat Bar shows what OpenMoat decides, so OpenMoat must be installed:
      brew install crocodile-labs/tap/openmoat

    OpenMoat Bar is not signed by Apple. The first time, open it from Finder
    with right-click > Open.
  EOS
end
