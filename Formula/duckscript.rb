class Duckscript < Formula
  desc "Simple, extendable and embeddable scripting language"
  homepage "https://sagiegurari.github.io/duckscript"
  url "https://github.com/sagiegurari/duckscript/archive/0.6.5.tar.gz"
  sha256 "5f80ec08476591697bc6c777452b6ab6f7c3700b2d0606384bf2b0f4090a9a8e"
  license "Apache-2.0"
  head "https://github.com/sagiegurari/duckscript.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "64360e8e5ad578b738f8da2cbb74f711a5de37901c15384091b931457014d50f" => :catalina
    sha256 "71b0a3a2cb1e931275b49509baafdce6ae35b6945efa521163233d87063b5b44" => :mojave
    sha256 "694be6568a521714bf1c7de78e9cf87d2f9a21fdfd0bebd2708397d26118501e" => :high_sierra
  end

  depends_on "rust" => :build

  def install
    cd "duckscript_cli" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    (testpath/"hello.ds").write <<~EOS
      out = set "Hello World"
      echo The out variable holds the value: ${out}    
    EOS
    output = shell_output("#{bin}/duck hello.ds")
    assert_match "The out variable holds the value: Hello World", output
  end
end
