# Postman Collection Execution Context

Tanggal konteks: 2026-04-29

## Status Legend

- `Implemented`: API layer, repository, dan UI flow dasar sudah ada
- `Partial`: API layer sudah ada, tetapi alur bisnis masih terbatas
- `Planned`: belum dikerjakan
- `Blocked`: perlu verifikasi backend/runtime

## Sudah Dieksekusi Dari Collection

### Auth

- `POST /pos/auth/login`: `Implemented`

### Category

- `GET /pos/category/list`: `Implemented`
- `GET /pos/category/detail/{id}`: `Implemented`
- `POST /pos/category/single/add`: `Implemented`
- `PUT /pos/category/update`: `Implemented`
- `DELETE /pos/category/delete/{id}`: `Implemented`

### Product

- `GET /pos/product/list`: `Implemented`
- `GET /pos/product/detail/{id}`: `Implemented`
- `POST /pos/product/add`: `Implemented`
- `PUT /pos/product/update`: `Implemented`
- `DELETE /pos/product/delete/{id}`: `Implemented`
- `POST /pos/product/recalculate-prices`: `Implemented`

### Variant / Modifier

- `POST /pos/product/{productId}/variant-group/add`: `Implemented`
- `PUT /pos/product/{productId}/variant-group/{variantGroupId}`: `Implemented`
- `DELETE /pos/product/{productId}/variant-group/{variantGroupId}`: `Implemented`
- `POST /pos/product/{productId}/variant/add`: `Implemented`
- `PUT /pos/product/{productId}/variant/{variantId}`: `Implemented`
- `PUT /pos/product/{productId}/variant/{variantId}/active`: `Implemented`
- `POST /pos/product/{productId}/modifier-group/add`: `Implemented`
- `PUT /pos/product/{productId}/modifier-group/{modifierGroupId}`: `Implemented`
- `DELETE /pos/product/{productId}/modifier-group/{modifierGroupId}`: `Implemented`
- `POST /pos/product/{productId}/modifier/add`: `Implemented`
- `PUT /pos/product/{productId}/modifier/{modifierId}`: `Implemented`
- `PUT /pos/product/{productId}/modifier/{modifierId}/active`: `Implemented`

### Transaction

- `GET /pos/transaction/list`: `Implemented`
- `GET /pos/transaction/detail/{id}`: `Implemented`
- `POST /pos/transaction/create`: `Implemented`
- `PUT /pos/transaction/initiate-payment/{merchant_trx_id}`: `Implemented`
- `PUT /pos/transaction/update/{merchant_trx_id}`: `Implemented`
- `GET /pos/payment-method/merchant/list`: `Implemented`

## UI Flow Yang Sudah Ada

- Login ke POS API
- Dashboard admin
- Sesi API / status token
- CRUD kategori
- CRUD produk
- Builder variant group dan variant item
- Builder modifier group dan modifier item
- Transaction console:
  - pilih produk
  - add ke cart multi-item
  - hitung subtotal, service, tax, rounding, grand total dari payment setting
  - pilih payment method
  - create transaction
  - lihat detail transaksi
  - initiate payment
  - mark paid
- stock update + stock movement
- payment setting editor
- summary report
- upload media

## Yang Masih Partial

- belum ada delete individual variant item karena collection tidak menyediakan endpoint delete-nya
- belum ada delete individual modifier item karena collection tidak menyediakan endpoint delete-nya
- semua menu laporan masih diarahkan ke satu summary report panel
- transaksi belum punya draft cart persistence

## Yang Belum Bisa Dipastikan

- CORS dari Flutter web ke domain API production
- kredensial valid di environment nyata
- konsistensi `merchant_trx_id` dengan `code`/`trxId`
- flow QRIS end-to-end tanpa webhook/callback sample
- payload production persis sama dengan sample Postman

## Risiko Teknis Saat Ini

- token session sudah persisten, tetapi belum ada refresh / expiry handling
- belum ada refresh session
- belum ada timeout/retry strategy
- belum ada pagination/filter UI untuk list besar

## Update Implementasi Tambahan

### Stock

- `PUT /pos/stock/update`: `Implemented`
- `GET /pos/stock-movement/product/list`: `Implemented`

### Payment Setting

- `GET /pos/payment-setting`: `Implemented`
- `POST /pos/payment-setting/create`: `Implemented`
- `PUT /pos/payment-setting/update`: `Implemented`

### Report

- `GET /pos/summary-report/list`: `Implemented`

### Upload

- `POST /images/upload`: `Implemented`

UI flow tambahan:

- menu `Stock`
- menu `Payment Setting`
- menu `Upload Media`
- seluruh menu `Laporan` mengarah ke summary report panel saat ini
