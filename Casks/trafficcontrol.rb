cask "trafficcontrol" do
  version :latest
  sha256 :no_check

  url "https://github.com/hakubo/TrafficControl/releases/latest/download/TrafficControl.dmg",
      verified: "github.com/hakubo/TrafficControl/"
  name "TrafficControl"
  desc "Send every link to the right browser, Chrome profile or desktop app"
  homepage "https://hakubo.github.io/TrafficControl/"

  # Always the latest release; after that the app keeps itself up to date.
  depends_on macos: :sonoma

  app "TrafficControl.app"

  # Releases aren't notarized yet, so clear the quarantine flag the download gets;
  # otherwise macOS refuses to open the app.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/TrafficControl.app"]
  end

  uninstall quit:       "io.github.hakubo.TrafficControl",
            login_item: "TrafficControl"

  zap trash: [
    "~/Library/Application Support/TrafficControl",
    "~/Library/Caches/io.github.hakubo.TrafficControl",
    "~/Library/HTTPStorages/io.github.hakubo.TrafficControl",
    "~/Library/Preferences/io.github.hakubo.TrafficControl.plist",
  ]

  caveats <<~EOS
    Open TrafficControl and click "Make Default" in its Settings so it receives your links.
  EOS
end
