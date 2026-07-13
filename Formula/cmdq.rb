class Cmdq < Formula
  desc "A PTY-hosted command queue: type the next command while one is still running."
  homepage "https://github.com/ParthJadhav/cmdq"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.6/cmdq-aarch64-apple-darwin.tar.xz"
      sha256 "839bc07e6a008ec0606bd3d9c150855c0ad0d77e89a5174c03a27b1a5aabc7f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.6/cmdq-x86_64-apple-darwin.tar.xz"
      sha256 "74fda1ee5bc7c0eee4b016ddaa9248da23e710a6d16bc1c1cc0e5546bd3acc6c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.6/cmdq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e4d988503f6c9f927c4ed22f30e82c04d4d83cc9a900af3290cfd0fb9a63a216"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.6/cmdq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "65bcdb0ddcc4e7b55eab09a352eae4dafdf7ea4df2839d113adfb83b51436e71"
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
