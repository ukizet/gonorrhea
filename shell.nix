{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  nativeBuildInputs = [
    pkg-config
    gobject-introspection
    cargo
    cargo-tauri
    nodejs
  ];

  buildInputs = [
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    librsvg
    libsoup_3
    pango
    webkitgtk_4_1
    openssl
    openjdk11
    android-studio
    android-studio-tools
    gradle
    rustc
    rustup
  ];
  shellHook = ''
    # export ANDROID_SDK_ROOT=$(nix eval --raw nixpkgs.androidsdk)
    # export ANDROID_NDK_ROOT=$(nix eval --raw nixpkgs.androidndk)
    echo "entered shell"
    export ANDROID_HOME="$HOME/Android/Sdk"
    export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
    export JAVA_HOME="${pkgs.android-studio}/jbr"
  '';
}
