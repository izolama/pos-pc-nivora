import '../config/api_endpoints.dart';
import '../models/api/api_response.dart';
import '../models/product/product_detail.dart';
import '../models/product/product_item.dart';
import '../models/product/product_mutation_result.dart';
import '../models/product/product_option_requests.dart';
import '../models/product/product_requests.dart';
import '../network/api_client.dart';

class ProductApiService {
  ProductApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<List<ProductItem>> getProducts({int size = 10}) async {
    final json = await _apiClient.get(
      ApiEndpoints.productList,
      queryParameters: {'size': size},
    );

    final response = ApiResponse<List<ProductItem>>.fromJson(
      json,
      (raw) =>
          ((raw as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(ProductItem.fromJson)
              .toList(),
    );

    return response.data;
  }

  Future<ProductDetail> getProductDetail(int productId) async {
    final json = await _apiClient.get(ApiEndpoints.productDetail(productId));
    final response = ApiResponse<ProductDetail>.fromJson(
      json,
      (raw) => ProductDetail.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<ProductMutationResult> createProduct(
    CreateProductRequest request,
  ) async {
    final json = await _apiClient.post(
      ApiEndpoints.productCreate,
      body: request.toJson(),
    );
    final response = ApiResponse<ProductMutationResult>.fromJson(
      json,
      (raw) => ProductMutationResult.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<void> updateProduct(UpdateProductRequest request) async {
    await _apiClient.put(ApiEndpoints.productUpdate, body: request.toJson());
  }

  Future<void> deleteProduct(int productId) async {
    await _apiClient.delete(ApiEndpoints.productDelete(productId));
  }

  Future<void> recalculatePrices() async {
    await _apiClient.post(ApiEndpoints.productRecalculatePrices);
  }

  Future<VariantGroup> addVariantGroup(
    int productId,
    UpsertVariantGroupRequest request,
  ) async {
    final json = await _apiClient.post(
      ApiEndpoints.addVariantGroup(productId),
      body: request.toJson(),
    );
    final response = ApiResponse<VariantGroup>.fromJson(
      json,
      (raw) => VariantGroup.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<VariantGroup> updateVariantGroup(
    int productId,
    int variantGroupId,
    UpsertVariantGroupRequest request,
  ) async {
    final json = await _apiClient.put(
      ApiEndpoints.updateVariantGroup(productId, variantGroupId),
      body: request.toJson(),
    );
    final response = ApiResponse<VariantGroup>.fromJson(
      json,
      (raw) => VariantGroup.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<void> deleteVariantGroup(int productId, int variantGroupId) async {
    await _apiClient.delete(
      ApiEndpoints.deleteVariantGroup(productId, variantGroupId),
    );
  }

  Future<VariantItem> addVariant(
    int productId,
    UpsertVariantRequest request,
  ) async {
    final json = await _apiClient.post(
      ApiEndpoints.addVariant(productId),
      body: request.toJson(),
    );
    final response = ApiResponse<VariantItem>.fromJson(
      json,
      (raw) => VariantItem.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<VariantItem> updateVariant(
    int productId,
    int variantId,
    UpsertVariantRequest request,
  ) async {
    final json = await _apiClient.put(
      ApiEndpoints.updateVariant(productId, variantId),
      body: request.toJson(),
    );
    final response = ApiResponse<VariantItem>.fromJson(
      json,
      (raw) => VariantItem.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<VariantItem> setVariantActive(
    int productId,
    int variantId,
    bool isActive,
  ) async {
    final json = await _apiClient.put(
      ApiEndpoints.setVariantActive(productId, variantId),
      queryParameters: {'isActive': isActive},
    );
    final response = ApiResponse<VariantItem>.fromJson(
      json,
      (raw) => VariantItem.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<ModifierGroup> addModifierGroup(
    int productId,
    UpsertModifierGroupRequest request,
  ) async {
    final json = await _apiClient.post(
      ApiEndpoints.addModifierGroup(productId),
      body: request.toJson(),
    );
    final response = ApiResponse<ModifierGroup>.fromJson(
      json,
      (raw) => ModifierGroup.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<ModifierGroup> updateModifierGroup(
    int productId,
    int modifierGroupId,
    UpsertModifierGroupRequest request,
  ) async {
    final json = await _apiClient.put(
      ApiEndpoints.updateModifierGroup(productId, modifierGroupId),
      body: request.toJson(),
    );
    final response = ApiResponse<ModifierGroup>.fromJson(
      json,
      (raw) => ModifierGroup.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<void> deleteModifierGroup(int productId, int modifierGroupId) async {
    await _apiClient.delete(
      ApiEndpoints.deleteModifierGroup(productId, modifierGroupId),
    );
  }

  Future<ModifierItem> addModifier(
    int productId,
    UpsertModifierRequest request,
  ) async {
    final json = await _apiClient.post(
      ApiEndpoints.addModifier(productId),
      body: request.toJson(),
    );
    final response = ApiResponse<ModifierItem>.fromJson(
      json,
      (raw) => ModifierItem.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<ModifierItem> updateModifier(
    int productId,
    int modifierId,
    UpsertModifierRequest request,
  ) async {
    final json = await _apiClient.put(
      ApiEndpoints.updateModifier(productId, modifierId),
      body: request.toJson(),
    );
    final response = ApiResponse<ModifierItem>.fromJson(
      json,
      (raw) => ModifierItem.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<ModifierItem> setModifierActive(
    int productId,
    int modifierId,
    bool isActive,
  ) async {
    final json = await _apiClient.put(
      ApiEndpoints.setModifierActive(productId, modifierId),
      queryParameters: {'isActive': isActive},
    );
    final response = ApiResponse<ModifierItem>.fromJson(
      json,
      (raw) => ModifierItem.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }
}
