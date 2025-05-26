{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  # /nix/store/3bhlykx0dp1rbd5z04sk40f3lapwalp4-androidsdk/libexec/android-sdk/ndk/26.1.10909125/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android21-clang

  env = {
    GREET = "devenv";
    NDK_HOME = "${config.env.ANDROID_NDK_ROOT}26.1.10909125"; 
    PATH = "$HOME/.cargo/bin:$PATH";
    AVD_NAME = "my-android-emulator-name";
    IMAGE = "system-images;android-32;google_apis_playstore;x86_64";
  };

  android.enable = true;

  languages = {
    javascript.enable = true;
    # rust.enable = true;
  };

  # https://devenv.sh/packages/
  packages = with pkgs; [ 
    git
    pkg-config
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    webkitgtk_4_1
    harfbuzz
    librsvg
    libsoup_3
    pango
    openssl
    openjdk11
    gradle
    zlib
    cargo
    cargo-tauri
    # rustc
    rustup
    gobject-introspection
    nodejs
    bun
    libxslt
    libxml2
  ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts = {
    hello.exec = ''
      echo hello from $GREET
      echo NDK_HOME=$NDK_HOME || echo NDK_HOME not set!!
    '';
    start.exec = ''bun install && bun run tauri android dev'';
    emulator.exec = ''avdmanager create avd --force --name my-android-emulator-name --package "system-images;android-32;google_apis_playstore;x86_64"'';
  };

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
