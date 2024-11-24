FROM rust:alpine

RUN apk add --no-cache \
    build-base \
    musl-dev \
    gcc \
    libc-dev \
    clang \
    curl \
    git \
    llvm \
    libffi-dev

WORKDIR /app

COPY ./src ./src
COPY ./tests ./tests
COPY ./.env ./.env
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# binstall permet de dl seulement les bin (et donc pas le code source + compilation en bin)
RUN ["cargo", "install", "cargo-binstall"]

# # cargo-llvm-cov : permet de générer des rapports de tests + code coverage
RUN ["cargo", "binstall", "cargo-llvm-cov" , "--secure" , "--no-confirm"]

# # cargo-nextest : improve le `cargo test` natif en améliorant entre autres le temps d'exe des tests
RUN ["cargo", "binstall", "cargo-nextest" , "--secure" , "--no-confirm"]

# # cargo-mutants : permet d'exe des tests par mutation
RUN ["cargo", "binstall", "cargo-mutants" , "--secure" , "--no-confirm"]

RUN ["cargo", "build"]

# ENTRYPOINT tail -f /dev/null
ENTRYPOINT ["./target/debug/back"]
