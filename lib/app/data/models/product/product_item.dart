import 'product_category_ref.dart';

class ProductItem {
  const ProductItem({
    required this.id,
    required this.merchantId,
    required this.merchantName,
    required this.name,
    required this.sku,
    required this.upc,
    required this.imageUrl,
    required this.imageThumbUrl,
    required this.description,
    required this.basePrice,
    required this.finalPrice,
    required this.qty,
    required this.productType,
    required this.isActive,
    required this.isStock,
    required this.categories,
  });

  final int id;
  final int merchantId;
  final String merchantName;
  final String name;
  final String sku;
  final String upc;
  final String imageUrl;
  final String imageThumbUrl;
  final String description;
  final double basePrice;
  final double finalPrice;
  final int qty;
  final String productType;
  final bool isActive;
  final bool isStock;
  final List<ProductCategoryRef> categories;

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      merchantId: (json['merchantId'] as num?)?.toInt() ?? 0,
      merchantName: json['merchantName']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      sku: json['sku']?.toString() ?? '',
      upc: json['upc']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      imageThumbUrl: json['imageThumbUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0,
      finalPrice: (json['finalPrice'] as num?)?.toDouble() ?? 0,
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      productType: json['productType']?.toString() ?? '',
      isActive: json['isActive'] as bool? ?? true,
      isStock: json['isStock'] as bool? ?? false,
      categories:
          ((json['categories'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(ProductCategoryRef.fromJson)
              .toList(),
    );
  }
}
