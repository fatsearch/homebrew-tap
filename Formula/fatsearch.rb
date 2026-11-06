class Fatsearch < Formula
  desc "Web pages and documents turned into small, clean, cached Markdown for AI agents"
  homepage "https://fatsearch.com"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.5/fatsearch-aarch64-apple-darwin.tar.xz"
      sha256 "fd0489a8d386aa5d5ec0108b7b75af86ef9f2bd96297a2b5a877c065c527f8ce"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.5/fatsearch-x86_64-apple-darwin.tar.xz"
      sha256 "53641d3886c3d47c9a87fcc89a7f16a030aa3728e33bd31cfe9653e7317b7d37"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.5/fatsearch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a3e56f53c619b5a921c2afc5acff1ac3f14f6b094f46d5571b3f4c7507abe362"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.5/fatsearch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3c6044f2de4d68f50c76b414a5e99def5afd6b8277a673f151107e1c10c94d7b"
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
