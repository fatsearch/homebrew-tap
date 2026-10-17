class Fatsearch < Formula
  desc "Web pages and documents turned into small, clean, cached Markdown for AI agents"
  homepage "https://github.com/fatsearch/fatsearch"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.2/fatsearch-aarch64-apple-darwin.tar.xz"
      sha256 "82f9eaf018ae9d34fb61eebc7d4d3ccfb7e33002d1658295ba4574b40251ab28"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.2/fatsearch-x86_64-apple-darwin.tar.xz"
      sha256 "c668756e585c6334be76283aed1a8b2e5e197de64991ec00eba4c4c5f17d2fc8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.2/fatsearch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "12ba9b7e150d727ac5e7fdce7946af2b327e21d4ea6dd9da0b13a1d9515fa20e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.1.2/fatsearch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bd7d46682c4e89f129d37fbc5a2acca476b327e1f7983ba60f2832270019803f"
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
