require "formula"

#
# Credit to https://github.com/Homebrew/homebrew/pull/17675/files
#

class DepotTools < Formula
  homepage 'https://dev.chromium.org/developers/how-tos/install-depot-tools'
  url 'https://chromium.googlesource.com/chromium/tools/depot_tools.git', :branch => 'master'
  version '2017.06.29'
  revision 1

  def install
    # Remove windows files
    rm_f Dir["*.bat"]
    # Install manuals
    man.install Dir["man/man1"]
    # Copy to libexec
    libexec.install Dir["*"]
    # Install binaries
    bin.mkpath unless bin.directory?
    Dir["#{libexec}/*"].each do |exec|
      bin.install_symlink exec if File.executable?(exec) and !File.directory?(exec)
    end
  end
end
