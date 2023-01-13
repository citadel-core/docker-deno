FROM rust:1.66-bullseye as builder

WORKDIR /deno

RUN apt update && apt install -y git

RUN git clone https://github.com/denoland/deno --recurse-submodules --depth=1 --branch v1.29.3 .

RUN cargo build --release

FROM debian:bullseye-slim

COPY --from=builder /deno/target/release/deno /usr/bin/deno
