class Cmdq < Formula
  desc "A PTY-hosted command queue: type the next command while one is still running."
  homepage "https://github.com/ParthJadhav/cmdq"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.3.3/cmdq-aarch64-apple-darwin.tar.xz"
      sha256 "5b786884c08b29ac572e2d904411e10726ffb61e53e6d25240a805296ee285b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.3.3/cmdq-x86_64-apple-darwin.tar.xz"
      sha256 "6bcd7becb806223302c5fbc51ac4f4d255fa8dc83cff5d42996ff4a3a878112a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.3.3/cmdq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "83f2abb82f44a4575918e7f911ad858b8d8902b09c5700e35c7e044910482a92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.3.3/cmdq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "61b8317f6dcc58d0cd7eb9028a48fe600bc43eed5629383a3f57a643975b4bda"
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
