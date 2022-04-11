FROM rust:1.59.0 as build
ENV PKG_CONFIG_ALLOW_CROSS=1
ENV SQLX_OFFLINE=true

WORKDIR /app

COPY . .

RUN cargo build --release

FROM gcr.io/distroless/cc-debian11

COPY --from=build /app/target/release/zero2prod /usr/bin
COPY --from=build /app/configuration.yaml .

ENTRYPOINT ["zero2prod"]