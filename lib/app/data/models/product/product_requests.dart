class CreateProductRequest {
  const CreateProductRequest({
    required this.name,
    required this.price,
    required this.sku,
    required this.upc,
    required this.imageUrl,
    required this.imageThumbUrl,
    required this.description,
    required this.qty,
    required this.productType,
    required this.isStock,
    required this.categoryIds,
  });

  final String name;
  final double price;
  final String sku;
  final String upc;
  final String imageUrl;
  final String imageThumbUrl;
  final String description;
  final int qty;
  final String productType;
  final bool isStock;
  final List<int> categoryIds;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'sku': sku,
      'upc': upc,
      'imageUrl': imageUrl,
      'imageThumbUrl': imageThumbUrl,
      'description': description,
      'qty': qty,
      'productType': productType,
      'isStock': isStock,
      'categoryIds': categoryIds,
    };
  }
}

class UpdateProductRequest extends CreateProductRequest {
  const UpdateProductRequest({
    required this.productId,
    required super.name,
    required super.price,
    required super.sku,
    required super.upc,
    required super.imageUrl,
    required super.imageThumbUrl,
    required super.description,
    required super.qty,
    required super.productType,
    required super.isStock,
    required super.categoryIds,
    required this.isActive,
  });

  final int productId;
  final bool isActive;

  @override
  Map<String, dynamic> toJson() {
    return {'productId': productId, ...super.toJson(), 'isActive': isActive};
  }
}
