class Openmoat < Formula
  desc "Policy checks for AI coding agents: decides allow, defer, ask or deny for every tool call from Claude Code, Codex, Cursor, OpenClaw, GitHub Copilot CLI, pi and Gemini CLI, configures Claude Code's, Codex's and Cursor's own OS sandboxes from the same policy, and keeps a local audit log."
  homepage "https://github.com/crocodile-labs/openmoat"
  version "0.12.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.12.1/openmoat-aarch64-apple-darwin.tar.xz"
      sha256 "583a8bf026a4e81d50621c7f8b0042eb4c2f5c19aac719c736ea29675ff5b04c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.12.1/openmoat-x86_64-apple-darwin.tar.xz"
      sha256 "39a6bd63bbf243676a8f09a6b772afca87a2bdc6b312adcbde2c150ed924d9c6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.12.1/openmoat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a03a46399c1b624ecd877d1ffc9845957d22e29ed78bbece5dc2622b7dff2742"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.12.1/openmoat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "70b58b4de4363a88834ebc4a3e53eb01e8875369cb473196e28fabfdbe90b15c"
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
