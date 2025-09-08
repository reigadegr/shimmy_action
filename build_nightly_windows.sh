#!/bin/bash

export RUSTFLAGS="
    -Z mir-opt-level=2 \
    -Z dylib-lto=yes \
    -Z inline-mir=yes \
    -Z fewer-names=yes \
    -Z box-noalias=yes \
    -Z share-generics=yes \
    -Z remap-cwd-prefix=. \
    -Z mutable-noalias=yes \
    -Z function-sections=yes \
    -Z dep-info-omit-d-target \
    -Z flatten-format-args=yes \
    -Z saturating-float-casts=yes \
    -Z mir-enable-passes=+Inline \
    -Z precise-enum-drop-elaboration=yes \
    -C relro-level=none \
    -C code-model=small \
    -C linker-plugin-lto=no \
    -C target-feature=+crt-static \
    -C symbol-mangling-version=v0 \
    -C link-arg=libcmt.lib \
    -C link-arg=/NODEFAULTLIB:msvcrt \
    -C link-arg=legacy_stdio_definitions.lib \
    -C link-arg=/OPT:REF,ICF \
    -C llvm-args=-fp-contract=off \
    -C llvm-args=-enable-misched \
    -C llvm-args=-enable-post-misched \
    -C llvm-args=-enable-dfa-jump-thread
"


cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +nightly build -r --target "$1" --bin "$2" -Z build-std -Z trim-paths --features llama
