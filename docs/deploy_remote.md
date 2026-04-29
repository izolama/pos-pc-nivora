# Remote Deploy

Script deploy tersedia di:

- `deploy/deploy_remote.sh`

## Default target

- host: `172.30.220.43`
- user: `shananfamily`
- remote dir: `/home/shananfamily/pos-pc-nivora`

## Requirement server

- SSH bisa diakses dari mesin lokal
- Docker dan Docker Compose tersedia di server
- Docker external network `shared-network` sudah ada
- `nginx` host dapat mengarah ke `127.0.0.1:8088` atau `localhost:8088`

## Jalankan deploy

```bash
chmod +x deploy/deploy_remote.sh
./deploy/deploy_remote.sh
```

## Override target

```bash
REMOTE_USER=myuser \
REMOTE_HOST=10.0.0.10 \
REMOTE_DIR=/home/myuser/pos-pc-nivora \
./deploy/deploy_remote.sh
```

## Yang dilakukan script

1. `flutter build web`
2. membuat arsip deploy
3. upload ke server via `scp`
4. extract bundle di server
5. `docker compose up -d --build`

## Catatan

- Script ini tetap meminta password SSH jika server belum memakai key-based auth.
- Jika koneksi SSH timeout, periksa VPN, routing jaringan, firewall, dan apakah port `22` server terbuka.
- Compose publish service ke `8088:80`, jadi app bisa diakses langsung lewat `http://IP_SERVER:8088`.
- `nginx` host tetap bisa menjadi reverse proxy dari domain publik ke `127.0.0.1:8088`.

## Sample reverse proxy

Contoh konfigurasi `nginx` untuk container/domain terpisah ada di:

- `deploy/reverse-proxy/pos-pc-nivora.conf`
- `deploy/reverse-proxy/pos-pc-nivora.http.conf`

Upstream yang dipakai:

- host: `127.0.0.1`
- port: `8088`

Contoh domain:

```nginx
server_name pos.nivora.id;
```

Konfigurasi sample saat ini sudah menyiapkan:

- redirect `HTTP` ke `HTTPS`
- upstream ke `127.0.0.1:8088`
- path sertifikat Let's Encrypt untuk `pos.nivora.id`

Path sertifikat yang dipakai:

```nginx
ssl_certificate /etc/letsencrypt/live/pos.nivora.id/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/pos.nivora.id/privkey.pem;
```

Jika sertifikat belum ada, buat dulu dengan `certbot` atau ubah sementara ke mode HTTP-only.

## HTTP-only testing

Jika `pos.nivora.id` ingin dihidupkan lebih dulu tanpa sertifikat, pakai:

- `deploy/reverse-proxy/pos-pc-nivora.http.conf`

File ini langsung proxy ke `pos-pc-nivora:80` lewat port `80` tanpa redirect HTTPS.
File ini langsung proxy ke `127.0.0.1:8088` lewat port `80` tanpa redirect HTTPS.

## Langkah pasang di server proxy

Contoh jika proxy host memakai `nginx` biasa:

```bash
sudo cp pos-pc-nivora.http.conf /etc/nginx/sites-available/pos.nivora.id.conf
sudo ln -s /etc/nginx/sites-available/pos.nivora.id.conf /etc/nginx/sites-enabled/pos.nivora.id.conf
sudo nginx -t
sudo systemctl reload nginx
```

Jika memakai config HTTPS:

```bash
sudo cp pos-pc-nivora.conf /etc/nginx/sites-available/pos.nivora.id.conf
sudo ln -s /etc/nginx/sites-available/pos.nivora.id.conf /etc/nginx/sites-enabled/pos.nivora.id.conf
sudo nginx -t
sudo systemctl reload nginx
```

Pastikan port lokal `127.0.0.1:8088` tidak dipakai service lain di host.
Pastikan port `8088` tidak dipakai service lain di host dan firewall mengizinkan akses jika ingin dibuka publik.
