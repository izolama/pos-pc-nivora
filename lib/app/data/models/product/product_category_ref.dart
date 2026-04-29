class ProductCategoryRef {
  const ProductCategoryRef({required this.id, required this.name});

  final int id;
  final String name;

  factory ProductCategoryRef.fromJson(Map<String, dynamic> json) {
    return ProductCategoryRef(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }
}
