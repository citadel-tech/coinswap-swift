#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COINSWAP_SWIFT_DIR="$SCRIPT_DIR"
FFI_REPO="https://github.com/citadel-tech/coinswap-ffi.git"
FFI_DIR="/tmp/coinswap-ffi"
FFI_COMMONS_DIR="$FFI_DIR/ffi-commons"

if [ ! -d "$FFI_DIR/.git" ]; then
    rm -rf "$FFI_DIR"
    git clone --depth 1 "$FFI_REPO" "$FFI_DIR"
fi

HEADER_BASENAME="CoinswapFFI"
TARGETDIR="$FFI_COMMONS_DIR/target"
NAME="coinswap_ffi"
PROFILE_DIR="debug"
SWIFT_OUT_DIR="$COINSWAP_SWIFT_DIR/Sources/Coinswap"

MAC_TARGET="x86_64-apple-darwin"
# MAC_TARGET="aarch64-apple-darwin"

cd "$FFI_COMMONS_DIR" || exit

rustup component add rust-src
rustup target add "$MAC_TARGET"

cargo build --package coinswap-ffi --target "$MAC_TARGET"

# # Copy dylib to Sources/CoinswapFFI
# mkdir -p ../coinswap-swift/Sources/CoinswapFFI
# cp ./target/$MAC_TARGET/$PROFILE_DIR/lib${NAME}.dylib ../coinswap-swift/Sources/CoinswapFFI/

UNIFFI_LIBRARY_PATH="./target/$MAC_TARGET/$PROFILE_DIR/lib${NAME}.dylib"
cargo run --bin uniffi-bindgen generate \
    --library "${UNIFFI_LIBRARY_PATH}" \
    --language swift \
    --out-dir "${SWIFT_OUT_DIR}" \
    --no-format

mkdir -p "$SWIFT_OUT_DIR/${HEADER_BASENAME}"
mv "$SWIFT_OUT_DIR/${HEADER_BASENAME}.h" "$SWIFT_OUT_DIR/${HEADER_BASENAME}/${HEADER_BASENAME}.h"
mv "$SWIFT_OUT_DIR/${HEADER_BASENAME}.modulemap" "$SWIFT_OUT_DIR/${HEADER_BASENAME}/module.modulemap"

cd "$COINSWAP_SWIFT_DIR" || exit

rm -rf "./coinswap_ffi.xcframework"

xcodebuild -create-xcframework \
    -library "${TARGETDIR}/${MAC_TARGET}/${PROFILE_DIR}/libcoinswap_ffi.a" \
    -headers "${SWIFT_OUT_DIR}/${HEADER_BASENAME}" \
    -output "./coinswap_ffi.xcframework"

# Keep Swift sources clean: only .swift files should stay in the package Sources dir
rm -rf "${SWIFT_OUT_DIR}/${HEADER_BASENAME}"
