class Cmdq < Formula
  desc "A PTY-hosted command queue: type the next command while one is still running."
  homepage "https://github.com/ParthJadhav/cmdq"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.5/cmdq-aarch64-apple-darwin.tar.xz"
      sha256 "51f8b27bcce483cc24d9c0148a6117e8c5228b8dc360b43ff35b3e1cdec59958"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.5/cmdq-x86_64-apple-darwin.tar.xz"
      sha256 "4589ed75cb619236e951633266e7f56e228354bbdba04a8dd8c5eaffb430fb99"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.5/cmdq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "17f5460db13c2d9544041d36fcdc19eb8852b9d18616395181616ebdd717a668"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.5/cmdq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9d7a8697102ff5909eba600193744a0282c6674af17d71928e7bcf181d2cfbef"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "cmdq" if OS.mac? && Hardware::CPU.arm?
    bin.install "cmdq" if OS.mac? && Hardware::CPU.intel?
    bin.install "cmdq" if OS.linux? && Hardware::CPU.arm?
    bin.install "cmdq" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
