require 'formula'

class Masurca < Formula
  homepage 'http://www.genome.umd.edu/masurca.html'
  url 'ftp://ftp.genome.umd.edu/pub/MaSuRCA/MaSuRCA-2.0.4.tar.gz'
  sha1 '7e36afd82bd581566d46fd4dedd7ffc6cd751fb2'

  keg_only 'MaSuRCA conflicts with jellyfish.'

  depends_on 'pkg-config' => :build

  fails_with :clang do
    build 425
    cause 'Jellyfish fails to build with clang.'
  end

  fails_with :llvm do
    build 2336
    cause 'Jellyfish fails to build with llvm-gcc.'
  end
  
  def patches
    # Fix the Jellyfish compiler error.
    DATA
  end

  def install
    ENV.j1
    ENV['DEST'] = prefix
    system 'sh -e ./install.sh'
  end

  test do
    system "#{bin}/runSRCA.pl"
  end
end

__END__
diff --git a/jellyfish-1.1.10/jellyfish/err.hpp b/jellyfish-1.1.10/jellyfish/err.hpp
index 14fc74b..93de4a0 100644
--- a/jellyfish-1.1.10/jellyfish/err.hpp
+++ b/jellyfish-1.1.10/jellyfish/err.hpp
@@ -41,7 +41,7 @@ namespace err {
     char  err_str[1024];
     char* str;
 
-#if (_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && ! _GNU_SOURCE
+#if 1 // (_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && ! _GNU_SOURCE
     int err = strerror_r(e, err_str, sizeof(err_str));
     if(err)
       strcpy(err_str, "error");
diff --git a/jellyfish-2.0.0beta6.1/include/jellyfish/err.hpp b/jellyfish-2.0.0beta6.1/include/jellyfish/err.hpp
index 3ebc324..6c5b846 100644
--- a/jellyfish-2.0.0beta6.1/include/jellyfish/err.hpp
+++ b/jellyfish-2.0.0beta6.1/include/jellyfish/err.hpp
@@ -42,7 +42,7 @@ public:
     char  err_str[1024];
     char* str;
 
-#if (_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && ! _GNU_SOURCE
+#if 1 // (_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && ! _GNU_SOURCE
     int err = strerror_r(e, err_str, sizeof(err_str));
     if(err)
       strcpy(err_str, "error");
