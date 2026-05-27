class VidCli < Formula
  desc "Create short reels from folders of images and videos with FFmpeg"
  homepage "https://github.com/ParthJadhav/vid-cli"
  version "0.1.1"

  github_token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
  github_headers = github_token.to_s.empty? ? [] : ["Authorization: Bearer #{github_token}"]

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/vid-cli/releases/download/v0.1.1/vid-cli-v0.1.1-aarch64-apple-darwin.tar.gz",
          headers: github_headers
      sha256 "14d4f1f36da4d02ecda1c8e873264d1288072bf715b9569222ba045ad9440a18"
    end

    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/vid-cli/releases/download/v0.1.1/vid-cli-v0.1.1-x86_64-apple-darwin.tar.gz",
          headers: github_headers
      sha256 "58cb88075373df2d0850966d8f7fd2fa89cd5ec05c1526a32ec679eaa3c798be"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ParthJadhav/vid-cli/releases/download/v0.1.1/vid-cli-v0.1.1-x86_64-unknown-linux-gnu.tar.gz",
        headers: github_headers
    sha256 "e9886b40d031c004f36f72c8ed410a6762fb4875541e18ffc17cb849f53e6b0e"
  end

  depends_on "ffmpeg"

  def install
    bin.install "vid-cli"
    pkgshare.install "README.md" if File.exist?("README.md")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/vid-cli --version")
  end
end
