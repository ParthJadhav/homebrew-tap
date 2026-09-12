class Cmdq < Formula
  desc "A PTY-hosted command queue: type the next command while one is still running."
  homepage "https://github.com/ParthJadhav/cmdq"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.2.0/cmdq-aarch64-apple-darwin.tar.xz"
      sha256 "6d585732cf6655e4a00363cdc3cd1e3ffa1190816831e0557b484eccb83e3ced"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.2.0/cmdq-x86_64-apple-darwin.tar.xz"
      sha256 "cd617b68406f00421fb31949b793cef162af94789c0e1b9b2771fa2bc8c0365b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.2.0/cmdq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a78c0480d324cd99b014a817a010b98fd60409728eb9fce824b5ce3f44776314"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.2.0/cmdq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "acd52ddd3fb2b56a29ea0b149f020ec58985948cb6ada11482266e875ae96128"
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
