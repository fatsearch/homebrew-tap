class Fatsearch < Formula
  desc "Web pages and documents turned into small, clean, cached Markdown for AI agents"
  homepage "https://fatsearch.com"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.2/fatsearch-aarch64-apple-darwin.tar.xz"
      sha256 "23a2472e5d01e521cef0a4e0e7a5e7f8b72e6264b6013296bcf57ba393aeaee8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.2/fatsearch-x86_64-apple-darwin.tar.xz"
      sha256 "a0f7788d7e49222c64115682e183958bf23f9d6f60dd1c1ed1d0a61011bf5f58"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.2/fatsearch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ef24db7740fcfe1a0f7548c22dc262e798b4a9a0e68583123cca08ae65c06a8e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.2/fatsearch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "573d089056fcf35bb47a9bbe5b5cfeb1e0a3743d2d6a3a7da1572a36e4380edb"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {
      fats: [
        "fatsearch",
      ],
    },
    "aarch64-unknown-linux-gnu": {
      fats: [
        "fatsearch",
      ],
    },
    "x86_64-apple-darwin":       {
      fats: [
        "fatsearch",
      ],
    },
    "x86_64-pc-windows-gnu":     {
      "fats.exe": [
        "fatsearch.exe",
      ],
    },
    "x86_64-unknown-linux-gnu":  {
      fats: [
        "fatsearch",
      ],
    },
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
