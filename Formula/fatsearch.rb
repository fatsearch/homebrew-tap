class Fatsearch < Formula
  desc "Web pages and documents turned into small, clean, cached Markdown for AI agents"
  homepage "https://github.com/fatsearch/fatsearch"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.3/fatsearch-aarch64-apple-darwin.tar.xz"
      sha256 "96187150898a9b0ab59d9a8e70a635b6416eced6640c7bf9062b52dc2dd325be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.3/fatsearch-x86_64-apple-darwin.tar.xz"
      sha256 "6ada8588403c59f5804cc754836a9916c09495b7c21b21ab4111f5dc1c16f985"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.3/fatsearch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "97b7c37674ec8d599a36c23ff21cc1b6c40c684269ad15d33dceea350ce90726"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.3/fatsearch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a61b31cfb8dc5406580572ac435b69931083d5c66253102d3af7ee5ca9a87c92"
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
