class Fatsearch < Formula
  desc "Web pages and documents turned into small, clean, cached Markdown for AI agents"
  homepage "https://fatsearch.com"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.4/fatsearch-aarch64-apple-darwin.tar.xz"
      sha256 "52e7dd1b3963edb4489a1318eac663f2c80257f28a1bd29ce0e51eb96d3124b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.4/fatsearch-x86_64-apple-darwin.tar.xz"
      sha256 "1f708062a4655da02ef37e4c948a29f5aa8b00b68f3760300e279ccf3a0396d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.4/fatsearch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "745072bfc1930c191d95d44f96f616e2dda837e19d7c54520d5ac437b304e3cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.4/fatsearch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1932f3706e0e5385c358ff1415274c766e6817d6ab29f8886f6212bdc870361e"
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
