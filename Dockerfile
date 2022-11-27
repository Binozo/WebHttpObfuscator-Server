FROM --platform=linux/amd64 dart:2.18.5-sdk AS BUILDER

WORKDIR /app
COPY . /app

# Get packages
RUN dart pub get

# Compile
RUN dart compile exe bin/webhttpobfuscator_server.dart -o server

FROM debian:buster-slim

WORKDIR /app/

COPY --from=BUILDER /app/server .

LABEL maintainer=binozoworks
LABEL org.opencontainers.image.source="https://github.com/Binozo/WebHttpObfuscator-Server"
LABEL org.opencontainers.image.description="Contains the endpoint for the WebHttpObfuscator Dart package"

CMD ["./server"]