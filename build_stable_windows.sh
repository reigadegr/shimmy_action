#!/bin/bash

export RUSTFLAGS="
    -C relro-level=none \
    -C code-model=small \
    -C linker-plugin-lto=no \
    -C link-arg=/OPT:REF,ICF \
    -C symbol-mangling-version=v0 \
    -C target-feature=+crt-static \
    -C link-arg=libucrt.lib \
    -C llvm-args=-fp-contract=off \
    -C llvm-args=-enable-misched \
    -C llvm-args=-enable-post-misched \
    -C llvm-args=-enable-dfa-jump-thread
" 

cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +stable build -r --target "$1" --bin "$2" --features llama
