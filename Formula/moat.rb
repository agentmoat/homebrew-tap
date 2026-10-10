class Moat < Formula
  desc "Policy guard for AI coding agents: decides allow, ask or deny for every tool call from Claude Code, Codex and Cursor, configures Claude Code's and Codex's own OS sandboxes from the same policy, and keeps a local audit log."
  homepage "https://github.com/crocodile-labs/openmoat"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.3.0/openmoat-aarch64-apple-darwin.tar.xz"
      sha256 "126f37cb2575a8a8043b522d2c60b30a0d968dce19480ded3433475480e69d18"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.3.0/openmoat-x86_64-apple-darwin.tar.xz"
      sha256 "5fc3b7395d7c6afcdcad7150bb64c53a356430ccfad811520718730fbed88e0e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.3.0/openmoat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "258188634369a1448097cfbb3fe6efa320325e74c2db185b262701838f415082"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.3.0/openmoat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f4570cd21d41094c80ffa7a15582c2b3912bcb596c40e2923d5cbafe40dd9431"
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
      bin.install "moat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "moat"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "moat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "moat"
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
