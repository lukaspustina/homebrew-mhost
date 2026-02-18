class Mhost < Formula
  desc "More than host - A modern take on the classic host DNS lookup utility"
  homepage "https://mhost.pustina.de"
  url "https://github.com/lukaspustina/mhost/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "baef4f91cf5fa05c351256bb6b85cb19876569d3c0d16a5d6b97137cf5d327fb"
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
