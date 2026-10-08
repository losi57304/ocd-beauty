# ocd.beauty
# Setup
## Environment variables
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

### Postiz
`POSTGRES_PASSWORD`
```sh
head -c 21 /dev/urandom | base64 | tr -d '\n'
```

`JWT_SECRET`
```sh
head -c 32 /dev/urandom | base64 | tr -d '\n'
```
