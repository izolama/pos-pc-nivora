class ProductMutationResult {
  const ProductMutationResult({required this.productId, required this.name});

  final int productId;
  final String name;

  factory ProductMutationResult.fromJson(Map<String, dynamic> json) {
    return ProductMutationResult(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }
}
