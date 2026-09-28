# ocd.beauty
# Setup
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
