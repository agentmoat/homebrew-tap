class Openmoat < Formula
  desc "Policy checks for AI coding agents: decides allow, defer, ask or deny for every tool call from Claude Code, Codex and Cursor, configures Claude Code's and Codex's own OS sandboxes from the same policy, and keeps a local audit log."
  homepage "https://github.com/crocodile-labs/openmoat"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.8.0/openmoat-aarch64-apple-darwin.tar.xz"
      sha256 "4e8beeda2f601010c6d222259c9661548f04dd67b658a647df945572566f1f5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.8.0/openmoat-x86_64-apple-darwin.tar.xz"
      sha256 "18f80a0ca448ba3da18af76cf0f00e939d45a941a740ecefdf6d47fa5c2cc274"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.8.0/openmoat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "25797490ebab148acf10ae3372c09d8f91e269c9413397d0ff6dda9021073145"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.8.0/openmoat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "151c07fcb28e5fb7e48225bbb4372a4d7ea42b09f45289828cd98c584ad4be33"
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
