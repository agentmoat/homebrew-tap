class Openmoat < Formula
  desc "Policy checks for AI coding agents: decides allow, defer, ask or deny for every tool call from Claude Code, Codex, Cursor, OpenClaw, GitHub Copilot CLI, pi and Gemini CLI, configures Claude Code's, Codex's and Cursor's own OS sandboxes from the same policy, and keeps a local audit log."
  homepage "https://github.com/crocodile-labs/openmoat"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.12.0/openmoat-aarch64-apple-darwin.tar.xz"
      sha256 "3ec55f340e0f51d80891cac3d7bb416662870d69bfa5b199c098b39a644c04e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.12.0/openmoat-x86_64-apple-darwin.tar.xz"
      sha256 "43d86d2340cf74ad36da37e6a83a2e36b92be1a26a73a01754e4709b3f7a3ce0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.12.0/openmoat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ee9f4803e4d1bdec4b01a655918374968b2d818b5e550f28530745261566d172"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.12.0/openmoat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "615a135d786a1fb1ab10ff7c84d489c941b738d888db810d8b0250a83e5c14f8"
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
