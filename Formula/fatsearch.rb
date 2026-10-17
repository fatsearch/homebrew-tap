class Fatsearch < Formula
  desc "Web pages and documents turned into small, clean, cached Markdown for AI agents"
  homepage "https://github.com/fatsearch/fatsearch"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.1/fatsearch-aarch64-apple-darwin.tar.xz"
      sha256 "44617bd2367dc0163c47aa7e39d8439e90bc4321d0ff5869790ac936ccc41c45"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.1/fatsearch-x86_64-apple-darwin.tar.xz"
      sha256 "e3431dd2c3caa9a6a85c893374e82d5e55910ead7396d0e2b16f07629bf5afed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.1/fatsearch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "90bc214e64844975197f649744abc5ef0f38588d3ca79cbe63a057f42433b38c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.1/fatsearch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "825f3dfa15c718bb6f21020e28b7feff3af74701f9de5fc1c65623600f848ac2"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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
      bin.install "fats"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fats"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fats"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fats"
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
