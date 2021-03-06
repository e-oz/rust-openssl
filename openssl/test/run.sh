#!/bin/bash
set -e

case "$BUILD_OPENSSL_VERSION" in
    1.0.2*)
        FEATURES="v102"
        ;;
    1.1.0*)
        FEATURES="v110"
        ;;
esac

echo Using features: $FEATURES

if [ -d "$HOME/openssl/lib" ]; then
    export OPENSSL_DIR=$HOME/openssl
    export PATH=$HOME/openssl/bin:$PATH
fi

if [ "$TARGET" == "arm-unknown-linux-gnueabihf" ]; then
    FLAGS="--no-run"
fi

cargo run --manifest-path systest/Cargo.toml --target $TARGET
exec cargo test --manifest-path openssl/Cargo.toml --target $TARGET \
    --features "$FEATURES" $FLAGS
