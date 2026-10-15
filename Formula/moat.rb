class Moat < Formula
  desc "Policy checks for AI coding agents: decides allow, defer, ask or deny for every tool call from Claude Code, Codex and Cursor, configures Claude Code's and Codex's own OS sandboxes from the same policy, and keeps a local audit log."
  homepage "https://github.com/crocodile-labs/openmoat"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.5.2/openmoat-aarch64-apple-darwin.tar.xz"
      sha256 "1ac1fd5043a4659d4baa1df3822a833673951a6dd4eb5a61efe308a72883ec37"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.5.2/openmoat-x86_64-apple-darwin.tar.xz"
      sha256 "8c63d17ed258df22d96954fa46996c87e10193cf3f0390164a7c523b7b59a559"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.5.2/openmoat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ddb514686e5fd2d00c50281b4d9b67e8cd1e09ae72c176bf7a77f4340bea111d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/crocodile-labs/openmoat/releases/download/v0.5.2/openmoat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "50421e42e43089057fec95a6a0bc75a10309e2fbb6ca3612094d478923458963"
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
