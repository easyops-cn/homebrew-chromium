require "formula"

#
# Credit to https://github.com/Homebrew/homebrew/pull/17675/files
#

class DepotTools < Formula
  homepage 'https://dev.chromium.org/developers/how-tos/install-depot-tools'
  url 'https://chromium.googlesource.com/chromium/tools/depot_tools.git', :branch => 'master'
  version '2017.06.29'

  depends_on 'repo'

  def install
    dst = prefix
    dst.mkpath unless dst.directory?
    mv Dir.glob('*'), dst
    %w[gclient gcl git-cl hammer drover cpplint.py presubmit_support.py
          git-try git-gs git-hyper-blame zsh-goodies].each do |tool|
          (bin/tool).write <<-EOS.undent
            #!/bin/bash
            TOOL=#{prefix}/#{tool}
            export DEPOT_TOOLS_UPDATE=0
            export PATH="$PATH:#{prefix}"
            exec "$TOOL" "$@"
          EOS
        end
  end

  test do
    %w[gclient presubmit_support.py].each do |tool|
      system "#{bin}/#{tool} --version"
    end
  end
end
