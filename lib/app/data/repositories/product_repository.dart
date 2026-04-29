import '../models/product/product_detail.dart';
import '../models/product/product_item.dart';
import '../models/product/product_mutation_result.dart';
import '../models/product/product_option_requests.dart';
import '../models/product/product_requests.dart';
import '../services/product_api_service.dart';

class ProductRepository {
  ProductRepository({required ProductApiService service}) : _service = service;

  final ProductApiService _service;

  Future<List<ProductItem>> getProducts({int size = 10}) {
    return _service.getProducts(size: size);
  }

  Future<ProductDetail> getProductDetail(int productId) {
    return _service.getProductDetail(productId);
  }

  Future<ProductMutationResult> createProduct({
    required String name,
    required double price,
    required String sku,
    required String upc,
    required String imageUrl,
    required String imageThumbUrl,
    required String description,
    required int qty,
    required String productType,
    required bool isStock,
    required List<int> categoryIds,
  }) {
    return _service.createProduct(
      CreateProductRequest(
        name: name,
        price: price,
        sku: sku,
        upc: upc,
        imageUrl: imageUrl,
        imageThumbUrl: imageThumbUrl,
        description: description,
        qty: qty,
        productType: productType,
        isStock: isStock,
        categoryIds: categoryIds,
      ),
    );
  }

  Future<void> updateProduct({
    required int productId,
    required String name,
    required double price,
    required String sku,
    required String upc,
    required String imageUrl,
    required String imageThumbUrl,
    required String description,
    required int qty,
    required String productType,
    required bool isStock,
    required bool isActive,
    required List<int> categoryIds,
  }) {
    return _service.updateProduct(
      UpdateProductRequest(
        productId: productId,
        name: name,
        price: price,
        sku: sku,
        upc: upc,
        imageUrl: imageUrl,
        imageThumbUrl: imageThumbUrl,
        description: description,
        qty: qty,
        productType: productType,
        isStock: isStock,
        categoryIds: categoryIds,
        isActive: isActive,
      ),
    );
  }

  Future<void> deleteProduct(int productId) {
    return _service.deleteProduct(productId);
  }

  Future<void> recalculatePrices() {
    return _service.recalculatePrices();
  }

  Future<VariantGroup> addVariantGroup({
    required int productId,
    required String name,
    required bool isRequired,
    required int displayOrder,
  }) {
    return _service.addVariantGroup(
      productId,
      UpsertVariantGroupRequest(
        name: name,
        isRequired: isRequired,
        displayOrder: displayOrder,
      ),
    );
  }

  Future<VariantGroup> updateVariantGroup({
    required int productId,
    required int variantGroupId,
    required String name,
    required bool isRequired,
    required int displayOrder,
  }) {
    return _service.updateVariantGroup(
      productId,
      variantGroupId,
      UpsertVariantGroupRequest(
        name: name,
        isRequired: isRequired,
        displayOrder: displayOrder,
      ),
    );
  }

  Future<void> deleteVariantGroup(int productId, int variantGroupId) {
    return _service.deleteVariantGroup(productId, variantGroupId);
  }

  Future<VariantItem> addVariant({
    required int productId,
    required int variantGroupId,
    required String name,
    required double additionalPrice,
    required String sku,
    required bool isStock,
    required bool isDefault,
    required int qty,
  }) {
    return _service.addVariant(
      productId,
      UpsertVariantRequest(
        variantGroupId: variantGroupId,
        name: name,
        additionalPrice: additionalPrice,
        sku: sku,
        isStock: isStock,
        isDefault: isDefault,
        qty: qty,
      ),
    );
  }

  Future<VariantItem> updateVariant({
    required int productId,
    required int variantId,
    required int variantGroupId,
    required String name,
    required double additionalPrice,
    required String sku,
    required bool isStock,
    required bool isDefault,
    required int qty,
  }) {
    return _service.updateVariant(
      productId,
      variantId,
      UpsertVariantRequest(
        variantGroupId: variantGroupId,
        name: name,
        additionalPrice: additionalPrice,
        sku: sku,
        isStock: isStock,
        isDefault: isDefault,
        qty: qty,
      ),
    );
  }

  Future<VariantItem> setVariantActive({
    required int productId,
    required int variantId,
    required bool isActive,
  }) {
    return _service.setVariantActive(productId, variantId, isActive);
  }

  Future<ModifierGroup> addModifierGroup({
    required int productId,
    required String name,
    required bool isRequired,
    required int minSelect,
    required int maxSelect,
    required int displayOrder,
  }) {
    return _service.addModifierGroup(
      productId,
      UpsertModifierGroupRequest(
        name: name,
        isRequired: isRequired,
        minSelect: minSelect,
        maxSelect: maxSelect,
        displayOrder: displayOrder,
      ),
    );
  }

  Future<ModifierGroup> updateModifierGroup({
    required int productId,
    required int modifierGroupId,
    required String name,
    required bool isRequired,
    required int minSelect,
    required int maxSelect,
    required int displayOrder,
  }) {
    return _service.updateModifierGroup(
      productId,
      modifierGroupId,
      UpsertModifierGroupRequest(
        name: name,
        isRequired: isRequired,
        minSelect: minSelect,
        maxSelect: maxSelect,
        displayOrder: displayOrder,
      ),
    );
  }

  Future<void> deleteModifierGroup(int productId, int modifierGroupId) {
    return _service.deleteModifierGroup(productId, modifierGroupId);
  }

  Future<ModifierItem> addModifier({
    required int productId,
    required int modifierGroupId,
    required String name,
    required double additionalPrice,
    required bool isStock,
    required bool isDefault,
  }) {
    return _service.addModifier(
      productId,
      UpsertModifierRequest(
        modifierGroupId: modifierGroupId,
        name: name,
        additionalPrice: additionalPrice,
        isStock: isStock,
        isDefault: isDefault,
      ),
    );
  }

  Future<ModifierItem> updateModifier({
    required int productId,
    required int modifierId,
    required int modifierGroupId,
    required String name,
    required double additionalPrice,
    required bool isStock,
    required bool isDefault,
  }) {
    return _service.updateModifier(
      productId,
      modifierId,
      UpsertModifierRequest(
        modifierGroupId: modifierGroupId,
        name: name,
        additionalPrice: additionalPrice,
        isStock: isStock,
        isDefault: isDefault,
      ),
    );
  }

  Future<ModifierItem> setModifierActive({
    required int productId,
    required int modifierId,
    required bool isActive,
  }) {
    return _service.setModifierActive(productId, modifierId, isActive);
  }
}
