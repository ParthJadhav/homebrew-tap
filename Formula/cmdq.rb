class Cmdq < Formula
  desc "A PTY-hosted command queue: type the next command while one is still running."
  homepage "https://github.com/ParthJadhav/cmdq"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.4.0/cmdq-aarch64-apple-darwin.tar.xz"
      sha256 "b00f77fc1d9948161b8452d5354f04df40c2657ff8b40ae8677d6e5d0288cebe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.4.0/cmdq-x86_64-apple-darwin.tar.xz"
      sha256 "b249c684cd8b798934e4f84331ef1d01ae2d32de2d14c68c7a02058ed8f875ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.4.0/cmdq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "14ee8ff0349c54ff8a8869dfdd96ecad0b471cf2d87b2a5143bb8470a06b32af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.4.0/cmdq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8229d5736e6ba70b076dcb96ebf8fc81b17b673b05860ea18eec54e81816244a"
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
