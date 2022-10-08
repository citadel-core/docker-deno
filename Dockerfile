FROM rust:1.64-bullseye as builder

WORKDIR /deno

RUN apt update && apt install -y git

RUN git clone https://github.com/denoland/deno --recurse-submodules --depth=1 --branch v1.26.1 .

RUN cargo build --release

FROM debian:bullseye-slim

COPY --from=builder /deno/target/release/deno /usr/bin/deno
