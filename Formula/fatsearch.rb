class Fatsearch < Formula
  desc "Web pages and documents turned into small, clean, cached Markdown for AI agents"
  homepage "https://fatsearch.com"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.1/fatsearch-aarch64-apple-darwin.tar.xz"
      sha256 "689a70670ad4171947461f7cdda4d6469bdaad38ea46ae32c0078857bf2debdd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.1/fatsearch-x86_64-apple-darwin.tar.xz"
      sha256 "553abdd3ba6f08a7aaed4d8c89ebf86884b0413f4cac9b76ef6cc96e560b31b0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.1/fatsearch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5181f9864c3a6cc087a3936fc0136afe015c0b41098d66966977afd778e7745d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fatsearch/fatsearch/releases/download/v0.2.1/fatsearch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9043e61bbed1268323a30b7f769ef10fc29f35f79e50ee010155f7a37d7c3888"
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
