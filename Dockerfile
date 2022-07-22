FROM rust:1.62-bullseye as builder

WORKDIR /deno

RUN apt update && apt install -y git

RUN git clone https://github.com/denoland/deno --recurse-submodules --depth=1 .

RUN RUST_BACKTRACE=1 cargo build -vv

FROM debian:bullseye-slim

COPY --from=builder /deno/target/release/deno /usr/bin/deno
