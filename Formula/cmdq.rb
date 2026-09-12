class Cmdq < Formula
  desc "A PTY-hosted command queue: type the next command while one is still running."
  homepage "https://github.com/ParthJadhav/cmdq"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.2.1/cmdq-aarch64-apple-darwin.tar.xz"
      sha256 "ccada6d6979701fd4f9f2c011a4fb0491949790211956f5246edf786685d934a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.2.1/cmdq-x86_64-apple-darwin.tar.xz"
      sha256 "bcfc359aa7d8556af25abad41dbc34d2d6d8900aba0f40c424872f4ee4ce07cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.2.1/cmdq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "95e804cf068c78c6c45dd24a4289605753124c53caabb63f461351c727721b59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.2.1/cmdq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2443bbd51bae0f7fcb9e7eeac2d33a79ff31fdc1cd6606164a5d5c0593eb3622"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "cmdq"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cmdq"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cmdq"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cmdq"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
