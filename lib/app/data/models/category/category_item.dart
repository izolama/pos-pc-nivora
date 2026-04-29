class CategoryItem {
  const CategoryItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  final int id;
  final String name;
  final String imageUrl;
  final String description;

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }
}
