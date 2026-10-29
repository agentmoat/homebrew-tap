class Openmoat < Formula
  desc "Policy checks for AI coding agents: decides allow, defer, ask or deny for every tool call from Claude Code, Codex, Cursor, OpenClaw, GitHub Copilot CLI, pi and Gemini CLI, configures Claude Code's, Codex's and Cursor's own OS sandboxes from the same policy, and keeps a local audit log."
  homepage "https://github.com/crocodile-labs/openmoat"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.11.0/openmoat-aarch64-apple-darwin.tar.xz"
      sha256 "d0204254c2c1673a8d70b8cf5b2ddbf0eb54ae3b623190f18f6a55beb9c73825"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.11.0/openmoat-x86_64-apple-darwin.tar.xz"
      sha256 "881d2ec1cea1d95dd10f27be1d1e5e0b90285a79b3842150d90ece57b069d6ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.11.0/openmoat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dd53792520e64a636d5e811e4a129902be8eb447e3248c77cb8009791a09210b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.11.0/openmoat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "15a3c84321fb0264d8265a0b65357c17cfd8248db28f6f20356c05b28678441e"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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
      bin.install "moat", "openmoat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "moat", "openmoat"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "moat", "openmoat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "moat", "openmoat"
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
