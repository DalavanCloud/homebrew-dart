require 'formula'

class Dart < Formula
  homepage 'https://www.dartlang.org/'

  version '1.9.1'
  if MacOS.prefer_64_bit?
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/44672/sdk/dartsdk-macos-x64-release.zip'
    sha256 '919908f1a315a1b7042522362dc656b5566ce5c2dc8f47c07140370b824b8c73'
  else
    url 'https://storage.googleapis.com/dart-archive/channels/stable/release/44672/sdk/dartsdk-macos-ia32-release.zip'
    sha256 'c2ca6250957fe61ac1131be70b212644f6e184b5ce1b4ce842339ed203d45005'
  end

  devel do
    version '1.10.0-dev.1.1'
    if MacOS.prefer_64_bit?
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45089/sdk/dartsdk-macos-x64-release.zip'
      sha256 '22506a0b9e2333f7939559d6e6ea3f419fb3aad9ce2540d1b8f01908e94ce84d'
    else
      url 'https://storage.googleapis.com/dart-archive/channels/dev/release/45089/sdk/dartsdk-macos-ia32-release.zip'
      sha256 '8ba1483c14f9f03a36f7edfe553cacd4f9211f81a3de301370233fb8add9abea'
    end
  end

  def install
    libexec.install Dir['*']
    bin.install_symlink "#{libexec}/bin/dart"
    bin.write_exec_script Dir["#{libexec}/bin/{pub,docgen,dart?*}"]
  end

  def caveats; <<-EOS.undent
    Please note the path to the Dart SDK:
      #{opt_libexec}
    EOS
  end

  test do
    (testpath/'sample.dart').write <<-EOS.undent
      void main() {
        print(r"test message");
      }
    EOS

    assert_equal "test message\n", shell_output("#{bin}/dart sample.dart")
  end
end
