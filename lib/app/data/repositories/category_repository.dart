import '../models/category/category_item.dart';
import '../models/category/category_mutation_result.dart';
import '../models/category/category_requests.dart';
import '../services/category_api_service.dart';

class CategoryRepository {
  CategoryRepository({required CategoryApiService service})
    : _service = service;

  final CategoryApiService _service;

  Future<List<CategoryItem>> getCategories({int size = 50}) {
    return _service.getCategories(size: size);
  }

  Future<CategoryItem> getCategoryDetail(int categoryId) {
    return _service.getCategoryDetail(categoryId);
  }

  Future<CategoryMutationResult> createCategory({
    required String name,
    required String image,
    required String description,
  }) {
    return _service.createCategory(
      UpsertCategoryRequest(name: name, image: image, description: description),
    );
  }

  Future<void> updateCategory({
    required int categoryId,
    required String name,
    required String image,
    required String description,
  }) {
    return _service.updateCategory(
      UpdateCategoryRequest(
        categoryId: categoryId,
        name: name,
        image: image,
        description: description,
      ),
    );
  }

  Future<void> deleteCategory(int categoryId) {
    return _service.deleteCategory(categoryId);
  }
}
