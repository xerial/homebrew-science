require 'formula'

class Bedops < Formula
  homepage 'https://github.com/bedops/bedops'
  url 'https://github.com/bedops/bedops/archive/v2.3.0.tar.gz'
  sha1 'ffb82320a8071af94bbf6e7d2d5834e5c8c14fc7'
  head 'https://github.com/bedops/bedops.git'

  fails_with :clang do
    build 500
    cause <<-EOS.undent
      error: assigning to 'struct hashtable_bucket *' from
      incompatible type 'void *'
    EOS
  end

  fails_with :llvm do
    build 5658
    cause <<-EOS.undent
      adler32.c:65: error: ‘uLong adler32’ redeclared as different kind of symbol
      zlib.h:1552: error: previous declaration of ‘uLong adler32(uLong, const Bytef*, uInt)’
    EOS
  end

  fails_with :gcc do
    build 5666
    cause <<-EOS.undent
      cc1plus: error: unrecognized command line option "-std=c++11"
    EOS
  end

  def install
    system 'make'
    system 'make', 'install'
    bin.install Dir['bin/*']
  end

  test do
    system "#{bin}/bedops", '--help'
  end
end
