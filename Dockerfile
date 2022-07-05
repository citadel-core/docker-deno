FROM rust:1.62-slim-bullseye as builder

WORKDIR /deno

RUN apt update && apt install -y git

RUN git clone https://github.com/denoland/deno --depth=1 .

RUN cargo build -vv

FROM debian:bullseye-slim

COPY --from=builder /deno/target/release/deno /usr/bin/deno
