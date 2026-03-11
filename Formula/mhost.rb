class Mhost < Formula
  desc "More than host - A modern take on the classic host DNS lookup utility"
  homepage "https://mhost.pustina.de"
  url "https://github.com/lukaspustina/mhost/archive/refs/tags/v0.11.2.tar.gz"
  sha256 "b0cfcd8c8dfa484818b000e9a607cf20f4b5cdd5d1b85c03fd58b9d6be680e9f"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/lukaspustina/mhost.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--features", "tui", *std_cargo_args

    out_dir = Dir["target/release/build/mhost-*/out"].first
    bash_completion.install "#{out_dir}/mhost.bash"
    fish_completion.install "#{out_dir}/mhost.fish"
    zsh_completion.install "#{out_dir}/_mhost"
  end

  test do
    assert_match "mhost", shell_output("#{bin}/mhost --version")
    assert_match "mdive", shell_output("#{bin}/mdive --help")
  end
end
