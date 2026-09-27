# ocd.beauty
```sh
apt update
apt upgrade -y
```

```sh
apt install -y ufw unattended-upgrades
```

```sh
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 8448/tcp # Continuwuity
ufw allow 50000:50100/udp # LiveKit Server

ufw --force enable
```

```sh
dpkg-reconfigure -f noninteractive unattended-upgrades
```

```sh
curl -fsSL https://get.docker.com -o get-docker.sh

sh ./get-docker.sh --dry-run
```

```sh
docker network create proxy
```

## glance
`AUTH_SECRET_KEY`
```sh
docker run --rm glanceapp/glance secret:make
```

## lk-jwt-service, livekit-server
`LIVEKIT_KEY`
`LIVEKIT_SECRET`
```sh
docker run --rm livekit/livekit-server generate-keys
```
