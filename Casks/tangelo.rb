cask "tangelo" do
  version "1.1.0"
  sha256 "2f504594a72c9655f58570d4d0d53d0401089cd362bb5d617cdd01272858762b"

  url "https://github.com/thisisrishi/Tangelo/releases/download/v#{version}/Tangelo.dmg"
  name "Tangelo"
  desc "Convert, edit and move files right where you drag them"
  homepage "https://github.com/thisisrishi/Tangelo"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Tangelo.app"

  # Tangelo is open source but not yet notarized; clear the quarantine flag so it opens normally.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tangelo.app"], must_succeed: false
  end

  uninstall quit: "io.github.thisisrishi.tangelo"

  zap trash: [
    "~/Library/Caches/io.github.thisisrishi.tangelo",
    "~/Library/Preferences/io.github.thisisrishi.tangelo.plist",
  ]

  caveats <<~EOS
    Optional helpers unlock more formats:
      brew install ffmpeg   # MP3, OGG, Opus, WMA, MKV, WebM, AVI, WMV
      brew install webp     # WebP encoding
  EOS
end
