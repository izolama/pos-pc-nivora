import '../config/api_endpoints.dart';
import '../models/api/api_response.dart';
import '../models/category/category_item.dart';
import '../models/category/category_mutation_result.dart';
import '../models/category/category_requests.dart';
import '../network/api_client.dart';

class CategoryApiService {
  CategoryApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<List<CategoryItem>> getCategories({int size = 50}) async {
    final json = await _apiClient.get(
      ApiEndpoints.categoryList,
      queryParameters: {'size': size},
    );

    final response = ApiResponse<List<CategoryItem>>.fromJson(
      json,
      (raw) =>
          ((raw as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(CategoryItem.fromJson)
              .toList(),
    );

    return response.data;
  }

  Future<CategoryItem> getCategoryDetail(int categoryId) async {
    final json = await _apiClient.get(ApiEndpoints.categoryDetail(categoryId));
    final response = ApiResponse<CategoryItem>.fromJson(
      json,
      (raw) => CategoryItem.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<CategoryMutationResult> createCategory(
    UpsertCategoryRequest request,
  ) async {
    final json = await _apiClient.post(
      ApiEndpoints.categoryCreate,
      body: request.toJson(),
    );
    final response = ApiResponse<CategoryMutationResult>.fromJson(
      json,
      (raw) => CategoryMutationResult.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<void> updateCategory(UpdateCategoryRequest request) async {
    await _apiClient.put(ApiEndpoints.categoryUpdate, body: request.toJson());
  }

  Future<void> deleteCategory(int categoryId) async {
    await _apiClient.delete(ApiEndpoints.categoryDelete(categoryId));
  }
}
