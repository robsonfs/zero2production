FROM rust:1.59.0 as build
ENV PKG_CONFIG_ALLOW_CROSS=1
ENV SQLX_OFFLINE=true

WORKDIR /app

COPY . .

RUN cargo build --release

FROM gcr.io/distroless/cc-debian11
ENV APP_ENVIRONMENT=production

WORKDIR /app
COPY --from=build /app/target/release/zero2prod /app/
COPY --from=build /app/configuration /app/configuration

ENTRYPOINT ["./zero2prod"]