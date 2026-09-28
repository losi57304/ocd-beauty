# ocd.beauty
- Debian 13

# Setup
```sh
apt update
apt upgrade -y
```

## UFW
```sh
apt install -y ufw
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

## Unattended upgrades
```sh
apt install -y unattended-upgrades
```

```sh
dpkg-reconfigure -f noninteractive unattended-upgrades
```

## Git
```sh
apt install -y git
```

## SOPS
```sh
curl -LO https://github.com/getsops/sops/releases/download/v3.13.3/sops-v3.13.3.linux.amd64

mv sops-v3.13.3.linux.amd64 /usr/local/bin/sops

chmod +x /usr/local/bin/sops
```

## Age
```sh
apt install -y age
```

```sh
mkdir -p ~/.config/sops/age

age-keygen -o ~/.config/sops/age/keys.txt

chmod 600 ~/.config/sops/age/keys.txt
```

## Just
```sh
apt install -y just
```

## Docker
```sh
curl -fsSL https://get.docker.com -o get-docker.sh

sh ./get-docker.sh --dry-run
```

```sh
docker network create proxy
```

## AWS CLI
```sh
apt install python3 python3-pip
```

```sh
pip install awscli --break-system-packages
```

## Environment variables
### Chat
`LIVEKIT_KEY`\
`LIVEKIT_SECRET`
```sh
docker run --rm livekit/livekit-server generate-keys
```

### Dashboard
`AUTH_SECRET_KEY`
```sh
docker run --rm glanceapp/glance secret:make
```

### Ente
`POSTGRES_PASSWORD`
```sh
head -c 21 /dev/urandom | base64 | tr -d '\n'
```

`GARAGE_RPC_SECRET`
```sh
openssl rand -hex 32
```

`ENTE_S3_B2_EU_CEN_KEY`\
`ENTE_S3_B2_EU_CEN_SECRET`
```sh
docker compose exec ente-garage /garage status
docker compose exec ente-garage /garage layout assign -z ocd-beauty -c 0G ...
docker compose exec ente-garage /garage layout apply --version 1
docker compose exec ente-garage /garage key create ente-key
docker compose exec ente-garage /garage bucket create b2-eu-cen
docker compose exec ente-garage /garage bucket allow --read --write --owner b2-eu-cen --key ente-key
```

`ENTE_JWT_SECRET`
```sh
head -c 32 /dev/urandom | base64 | tr -d '\n' | tr '+/' '-_'
```

`ENTE_KEY_ENCRYPTION`
```sh
head -c 32 /dev/urandom | base64 | tr -d '\n'
```

`ENTE_KEY_HASH`
```sh
head -c 64 /dev/urandom | base64 | tr -d '\n'
```

## Containers
### Ente
```sh
export AWS_ACCESS_KEY_ID=...
export AWS_DEFAULT_REGION=garage
export AWS_SECRET_ACCESS_KEY=...

CORS='{"CORSRules":[{"AllowedHeaders":["*"],"AllowedMethods":["GET","PUT","POST","DELETE"],"AllowedOrigins":["*"],"ExposeHeaders":["ETag"]}]}'

aws --endpoint-url https://storage.ente.ocd.beauty s3api put-bucket-cors \
  --bucket b2-eu-cen \
  --cors-configuration "$CORS"
```

# Post-setup
```sh
pip uninstall awsli
```
