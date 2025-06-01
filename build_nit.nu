#!/usr/bin/env nu

# Have to set these to match the Rust commit targetted by Cargo.toml.
$env.CFG_RELEASE = '1.88.0-nightly'
$env.CFG_RELEASE_CHANNEL = 'nightly'
# Otherwise Rust complains we're building the compiler without bootstrapping.
# I reckon it's fine.
$env.RUSTC_BOOTSTRAP = '0'

# Build rustfmt for WASI.
cargo build --release --target wasm32-wasip2

# Set Nit metadata. This just adds a WASM custom section containing the
# metadata.json file. It's only used for Nit.
nit set-metadata --metadata metadata.json target/wasm32-wasip2/release/rustfmt.wasm
