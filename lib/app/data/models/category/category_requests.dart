class UpsertCategoryRequest {
  const UpsertCategoryRequest({
    required this.name,
    required this.image,
    required this.description,
  });

  final String name;
  final String image;
  final String description;

  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image, 'description': description};
  }
}

class UpdateCategoryRequest extends UpsertCategoryRequest {
  const UpdateCategoryRequest({
    required this.categoryId,
    required super.name,
    required super.image,
    required super.description,
  });

  final int categoryId;

  @override
  Map<String, dynamic> toJson() {
    return {'categoryId': categoryId, ...super.toJson()};
  }
}
