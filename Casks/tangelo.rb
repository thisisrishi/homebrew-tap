cask "tangelo" do
  version "1.0.0"
  sha256 "616e61a4d83daa41e19d10f154af026e32c86fa442bfe46fb2239b2046f6f655"

  url "https://github.com/thisisrishi/Tangelo/releases/download/v#{version}/Tangelo.dmg"
  name "Tangelo"
  desc "Convert, edit and move files right where you drag them"
  homepage "https://github.com/thisisrishi/Tangelo"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Tangelo.app"

  # Tangelo is open source but not yet notarized; clear the quarantine flag so it opens normally.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Tangelo.app"],
                   sudo: false
  end

  uninstall quit: "io.github.thisisrishi.tangelo"

  zap trash: [
    "~/Library/Preferences/io.github.thisisrishi.tangelo.plist",
    "~/Library/Caches/io.github.thisisrishi.tangelo",
  ]

  caveats <<~EOS
    Optional helpers unlock more formats:
      brew install ffmpeg   # MP3, OGG, Opus, WMA, MKV, WebM, AVI, WMV
      brew install webp     # WebP encoding
  EOS
end
