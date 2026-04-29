# Cashlez API Mapping

Dokumen ini memetakan Postman collection `Cashlez POS API` ke model Dart dan layer implementasi di POS PC Nivora.

## Scope implementasi saat ini

Modul yang sudah punya data layer dan UI dasar:

- `Auth`
- `Category`
- `Product`
- `Variant/Modifier`
- `Stock`
- `Transaction`
- `Payment Setting`
- `Report`
- `Upload`

## Service boundaries

- `ApiClient`: wrapper HTTP, bearer token, JSON parsing, dan error mapping
- `AuthApiService`: login dan token session
- `CategoryApiService`: category CRUD
- `ProductApiService`: product CRUD dan list/detail
- `StockApiService`: update stock dan movement list
- `TransactionApiService`: list/detail/create transaction, initiate payment, mark paid
- `PaymentSettingApiService`: get/create/update payment setting
- `ReportApiService`: summary report
- `UploadApiService`: upload image multipart
- `Repository`: memisahkan service HTTP dari modul UI/GetX

## Endpoint to Dart model mapping

### Auth

`POST /pos/auth/login`

Request model:

- `AuthLoginRequest`
  - `username`
  - `password`

Response model:

- `AuthSession`
  - `token`

### Category

`GET /pos/category/list`

Response model:

- `CategoryItem`
  - `id`
  - `name`
  - `imageUrl`
  - `description`

`GET /pos/category/detail/{id}`

Response model:

- `CategoryItem`

`POST /pos/category/single/add`

Request model:

- `UpsertCategoryRequest`
  - `name`
  - `image`
  - `description`

Response model:

- `CategoryMutationResult`
  - `categoryId`
  - `name`

`PUT /pos/category/update`

Request model:

- `UpdateCategoryRequest`
  - `categoryId`
  - `name`
  - `image`
  - `description`

### Product

`GET /pos/product/list`

Response model:

- `ProductItem`
  - `id`
  - `merchantId`
  - `merchantName`
  - `name`
  - `sku`
  - `upc`
  - `imageUrl`
  - `imageThumbUrl`
  - `description`
  - `basePrice`
  - `finalPrice`
  - `qty`
  - `productType`
  - `isActive`
  - `isStock`
  - `categories`

`GET /pos/product/detail/{id}`

Response model:

- `ProductDetail`
  - semua field `ProductItem`
  - `variantGroups`
  - `modifierGroups`

Nested model:

- `ProductCategoryRef`
- `VariantGroup`
- `VariantItem`
- `ModifierGroup`
- `ModifierItem`

`POST /pos/product/add`

Request model:

- `CreateProductRequest`
  - `name`
  - `price`
  - `sku`
  - `upc`
  - `imageUrl`
  - `imageThumbUrl`
  - `description`
  - `qty`
  - `productType`
  - `isStock`
  - `categoryIds`

Response model:

- `ProductMutationResult`
  - `productId`
  - `name`

`PUT /pos/product/update`

Request model:

- `UpdateProductRequest`
  - `productId`
  - `name`
  - `price`
  - `sku`
  - `upc`
  - `imageUrl`
  - `imageThumbUrl`
  - `description`
  - `isActive`
  - `isStock`
  - `categoryIds`

### Variant / Modifier

Request model:

- `UpsertVariantGroupRequest`
- `UpsertVariantRequest`
- `UpsertModifierGroupRequest`
- `UpsertModifierRequest`

Response / nested model:

- `VariantGroup`
- `VariantItem`
- `ModifierGroup`
- `ModifierItem`

### Stock

Request model:

- `StockUpdateRequest`

Response model:

- `StockMovementItem`

### Transaction

Request model:

- `CreateTransactionRequest`
- `CreateTransactionItemRequest`
- `InitiatePaymentRequest`
- `UpdateTransactionPaymentRequest`

State/UI model:

- `CartItemModel`

Response model:

- `TransactionSummaryItem`
- `TransactionDetail`
- `TransactionDetailItem`
- `TransactionMutationResult`
- `PaymentMethodGroup`
- `PaymentMethodItem`

### Payment Setting

Request model:

- `PaymentSettingRequest`

Response model:

- `PaymentSettingModel`

### Report

Response model:

- `SummaryReportModel`
- `ReportProductItem`
- `ReportPaymentItem`

### Upload

Response model:

- `UploadImageResult`

## Implemented UI Flow

- login dan persist token session
- dashboard admin POS
- sesi API aktif / logout
- category CRUD
- product CRUD
- variant / modifier builder
- stock update dan stock movement list
- payment setting editor
- transaction cart multi-item
- initiate payment dan mark paid
- summary report
- upload media

## Remaining gaps

Masih ada gap, meski fondasi endpoint collection hampir seluruhnya sudah terpasang:

- belum ada endpoint delete variant item individual di collection
- belum ada endpoint delete modifier item individual di collection
- transaksi belum punya cart persistence draft
- detail validasi backend production belum teruji end-to-end
- POS tablet sync belum dibangun

## Known API inconsistencies to isolate in repository layer

- `price` pada request produk, tetapi `basePrice/finalPrice` pada response
- `image` pada request category, tetapi `imageUrl` pada response
- sebagian nominal dikirim sebagai `String`, sebagian sebagai `double`
- `merchant_trx_id`, `trxId`, `code`, dan `transactionId` harus dinormalisasi di model transaksi

## Recommendation

UI GetX sebaiknya hanya memakai repository dan domain model. Parsing response, fallback null, dan perbedaan field API harus tetap di layer data agar modul POS tablet dan POS PC bisa berbagi kontrak yang sama.
