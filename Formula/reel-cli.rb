class ReelCli < Formula
  desc "Create short reels from folders of images and videos with FFmpeg"
  homepage "https://github.com/ParthJadhav/reel-cli"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/reel-cli/releases/download/v0.1.2/reel-cli-aarch64-apple-darwin.tar.gz"
      sha256 "76c7212ffe949ffdc026764e839dbeb016bca3df959021cd45cda5fb84d4a50c"
    end

    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/reel-cli/releases/download/v0.1.2/reel-cli-x86_64-apple-darwin.tar.gz"
      sha256 "62659e7b8dc105b9585c7387d4e2c143f46b554d921c756ce6cd4491cbdc7414"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ParthJadhav/reel-cli/releases/download/v0.1.2/reel-cli-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "609674a5e6eeb67bb0541fbab61e189b3e94ace18e1d5ba833afcc6d31b18997"
  end

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  def install
    bin.install "reel-cli"
    pkgshare.install "README.md" if File.exist?("README.md")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/reel-cli --version")
    system "#{bin}/reel-cli", "--doctor"
  end
end
