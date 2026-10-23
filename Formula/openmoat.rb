class Openmoat < Formula
  desc "Policy checks for AI coding agents: decides allow, defer, ask or deny for every tool call from Claude Code, Codex, Cursor, OpenClaw, GitHub Copilot CLI, pi and Gemini CLI, configures Claude Code's, Codex's and Cursor's own OS sandboxes from the same policy, and keeps a local audit log."
  homepage "https://github.com/crocodile-labs/openmoat"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.10.0/openmoat-aarch64-apple-darwin.tar.xz"
      sha256 "66bbd8a040479d17111efa01d357bd772aedd2c32bf097369c8f0f11a58165b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.10.0/openmoat-x86_64-apple-darwin.tar.xz"
      sha256 "951bb119610cd18d287328c427b274f1634bd9a69c4c55f0c35660e1b962a6fb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.10.0/openmoat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "01f35b7fa4249b1e737cdd90fba709d3c4da18cb233075d959985b4b4a22b468"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.10.0/openmoat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b38218dfc3e57cfd2f26d90d47df67271165dda9875a64986b7655dafbf826bc"
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
