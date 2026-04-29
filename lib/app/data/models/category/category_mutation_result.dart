class CategoryMutationResult {
  const CategoryMutationResult({required this.categoryId, required this.name});

  final int categoryId;
  final String name;

  factory CategoryMutationResult.fromJson(Map<String, dynamic> json) {
    return CategoryMutationResult(
      categoryId: (json['categoryId'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }
}
