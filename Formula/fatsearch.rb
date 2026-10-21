class Fatsearch < Formula
  desc "Web pages and documents turned into small, clean, cached Markdown for AI agents"
  homepage "https://fatsearch.com"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.3/fatsearch-aarch64-apple-darwin.tar.xz"
      sha256 "299b04a4cb0ce5543401fed641aeddcf5e84d8277f54128aa580012e7458fbf4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.3/fatsearch-x86_64-apple-darwin.tar.xz"
      sha256 "03fb8e01fc2ac0ded0bcdf35ae400801a8d85565f1c9138d01257ac753b88758"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.3/fatsearch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b1c7523286ca733831b4c2e2af8e11058eb924da76e626878463866047aa49f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.3/fatsearch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e624efea4b6cfc9b86af68c9f1ea8ad568edfac151c177c6ee09926aec3c3a4d"
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
