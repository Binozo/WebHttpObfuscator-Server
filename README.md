# WebHttpObfuscator-Server
Middleman Server for [WebHttpObfuscator](https://github.com/Binozo/WebHttpObfuscator)

## Dependencies
- Docker
- Dart SDK

## Usage
You need to configure and compile the Server for yourself.

```bash
git clone https://github.com/Binozo/WebHttpObfuscator-Server.git
cd WebHttpObfuscator-Server
dart pub get
```

Now you need to edit the `bin/webhttpobfuscator_server.dart` file.
Change the port, encryption and decryption function as you wish.

⚠️If you don't change it, it will send everything in plain text⚠️

Now build your docker container
```bash
docker build -t ghcr.io/binozo/webhttpobfuscator-server:latest .
```

Run it
```bash
docker run -p 9268:9268 -d ghcr.io/binozo/webhttpobfuscator-server:latest
```

docker compose:
```yaml
version: "3.9"
services:
  WebHttpObfuscator-Server:
    restart: always
    image: ghcr.io/binozo/webhttpobfuscator-server:latest
    ports:
      - "9268:9268"
    container_name: "WebHttpObfuscator-Server"
```