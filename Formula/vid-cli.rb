class VidCli < Formula
  desc "Create short reels from folders of images and videos with FFmpeg"
  homepage "https://github.com/ParthJadhav/vid-cli"
  url "https://github.com/ParthJadhav/vid-cli.git",
      tag:      "v0.1.1",
      revision: "c7d80430156c0f0f77185e3a0cd4f22d84fba983"
  version "0.1.1"

  depends_on "rust" => :build
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vid-cli --version")
  end
end
