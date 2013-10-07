require 'formula'

class Dbgfm < Formula
  homepage 'https://github.com/jts/dbgfm'
  url 'https://github.com/jts/dbgfm/archive/0.1.tar.gz'
  sha1 'b9c191950cb6b331bdcf377ba3ab1c2c2776f5ab'
  head 'https://github.com/jts/dbgfm.git'

  def install
    mkdir_p [bin, include, lib]
    system 'make', 'install', "prefix=#{prefix}"
  end

  test do
    system 'dbgfm 2>&1 |grep -q dbgfm'
  end
end
