class Cmdq < Formula
  desc "A PTY-hosted command queue: type the next command while one is still running."
  homepage "https://github.com/ParthJadhav/cmdq"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.4/cmdq-aarch64-apple-darwin.tar.xz"
      sha256 "a3a14cbdd70ec4aca0414192d7da4d74d009aa9b8813ecc774cfd065d4b95642"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.4/cmdq-x86_64-apple-darwin.tar.xz"
      sha256 "4e2188120cb62c7acb3af02bcb43db2ae0ee9d542a55ed59d3b0cd4a4d85b299"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.4/cmdq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "17c4189e3a3fdbe41b2b05d7cd4d994f4f9366e14545f22f0043f0d77f5116cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.4/cmdq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4d35995c628ad175205ebacf7dabe60cfe6c31fd26e9c1dbdd155fb6653afc6b"
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
