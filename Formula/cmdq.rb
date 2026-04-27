class Cmdq < Formula
  desc "A PTY-hosted command queue: type the next command while one is still running."
  homepage "https://github.com/ParthJadhav/cmdq"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.3/cmdq-aarch64-apple-darwin.tar.xz"
      sha256 "31fa978adbb1dff32698a843fc06f4fec51f7b5bf6c01b100af7ec9b30af53ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.3/cmdq-x86_64-apple-darwin.tar.xz"
      sha256 "22aadbb01d5d3ca2bf7eb4074bd367d7c57cf485b8becb8825c9ce7d0bc996fb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.3/cmdq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4cc61de911b47598f947d8d9496079885b62054362465f72a923ede3d8db5c98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ParthJadhav/cmdq/releases/download/v0.1.3/cmdq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0961433a0da4528586e8651e54be661b72705d00584ceaccefafe661ebbeb326"
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
