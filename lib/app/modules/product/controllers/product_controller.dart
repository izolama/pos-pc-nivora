import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/exceptions/app_exception.dart';
import '../../../data/models/category/category_item.dart';
import '../../../data/models/product/product_detail.dart';
import '../../../data/models/product/product_item.dart';
import '../../../data/repositories/category_repository.dart';
import '../../../data/repositories/product_repository.dart';

class ProductController extends GetxController {
  ProductController({
    required ProductRepository productRepository,
    required CategoryRepository categoryRepository,
  }) : _productRepository = productRepository,
       _categoryRepository = categoryRepository;

  final ProductRepository _productRepository;
  final CategoryRepository _categoryRepository;

  final products = <ProductItem>[].obs;
  final categories = <CategoryItem>[].obs;
  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final errorMessage = ''.obs;
  final selectedDetail = Rxn<ProductDetail>();

  final nameController = TextEditingController();
  final skuController = TextEditingController();
  final upcController = TextEditingController();
  final imageUrlController = TextEditingController();
  final imageThumbUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController(text: '0');
  final qtyController = TextEditingController(text: '0');

  final selectedProductId = RxnInt();
  final selectedCategoryId = RxnInt();
  final isStock = true.obs;
  final isActive = true.obs;

  final variantGroupNameController = TextEditingController();
  final variantGroupDisplayOrderController = TextEditingController(text: '1');
  final variantNameController = TextEditingController();
  final variantAdditionalPriceController = TextEditingController(text: '0');
  final variantSkuController = TextEditingController();
  final variantQtyController = TextEditingController(text: '0');
  final variantGroupId = RxnInt();
  final selectedVariantId = RxnInt();
  final variantGroupRequired = false.obs;
  final variantIsStock = true.obs;
  final variantIsDefault = false.obs;

  final modifierGroupNameController = TextEditingController();
  final modifierGroupDisplayOrderController = TextEditingController(text: '1');
  final modifierGroupMinSelectController = TextEditingController(text: '0');
  final modifierGroupMaxSelectController = TextEditingController(text: '1');
  final modifierNameController = TextEditingController();
  final modifierAdditionalPriceController = TextEditingController(text: '0');
  final modifierGroupId = RxnInt();
  final selectedModifierId = RxnInt();
  final modifierGroupRequired = false.obs;
  final modifierIsStock = false.obs;
  final modifierIsDefault = false.obs;

  bool get isEditing => selectedProductId.value != null;

  @override
  void onClose() {
    nameController.dispose();
    skuController.dispose();
    upcController.dispose();
    imageUrlController.dispose();
    imageThumbUrlController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    qtyController.dispose();
    variantGroupNameController.dispose();
    variantGroupDisplayOrderController.dispose();
    variantNameController.dispose();
    variantAdditionalPriceController.dispose();
    variantSkuController.dispose();
    variantQtyController.dispose();
    modifierGroupNameController.dispose();
    modifierGroupDisplayOrderController.dispose();
    modifierGroupMinSelectController.dispose();
    modifierGroupMaxSelectController.dispose();
    modifierNameController.dispose();
    modifierAdditionalPriceController.dispose();
    super.onClose();
  }

  Future<void> loadInitialData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final loadedCategories = await _categoryRepository.getCategories();
      categories.assignAll(loadedCategories);
      if (loadedCategories.isNotEmpty && selectedCategoryId.value == null) {
        selectedCategoryId.value = loadedCategories.first.id;
      }
      products.assignAll(await _productRepository.getProducts());
      if (selectedProductId.value != null) {
        await loadProductDetail(selectedProductId.value!);
      }
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat produk.';
    } finally {
      isLoading.value = false;
    }
  }

  void startCreate() {
    selectedProductId.value = null;
    nameController.clear();
    skuController.clear();
    upcController.clear();
    imageUrlController.clear();
    imageThumbUrlController.clear();
    descriptionController.clear();
    priceController.text = '0';
    qtyController.text = '0';
    isStock.value = true;
    isActive.value = true;
    if (categories.isNotEmpty) {
      selectedCategoryId.value = categories.first.id;
    }
    selectedDetail.value = null;
    clearVariantForms();
    clearModifierForms();
  }

  void startEdit(ProductItem item) {
    selectedProductId.value = item.id;
    nameController.text = item.name;
    skuController.text = item.sku;
    upcController.text = item.upc;
    imageUrlController.text = item.imageUrl;
    imageThumbUrlController.text = item.imageThumbUrl;
    descriptionController.text = item.description;
    priceController.text = item.finalPrice.toStringAsFixed(0);
    qtyController.text = item.qty.toString();
    isStock.value = item.isStock;
    isActive.value = item.isActive;
    if (item.categories.isNotEmpty) {
      selectedCategoryId.value = item.categories.first.id;
    }
    loadProductDetail(item.id);
  }

  Future<void> submit() async {
    final categoryId = selectedCategoryId.value;
    if (categoryId == null) {
      errorMessage.value = 'Pilih kategori terlebih dahulu.';
      return;
    }

    isSubmitting.value = true;
    errorMessage.value = '';

    try {
      if (isEditing) {
        await _productRepository.updateProduct(
          productId: selectedProductId.value!,
          name: nameController.text.trim(),
          price: double.tryParse(priceController.text.trim()) ?? 0,
          sku: skuController.text.trim(),
          upc: upcController.text.trim(),
          imageUrl: imageUrlController.text.trim(),
          imageThumbUrl: imageThumbUrlController.text.trim(),
          description: descriptionController.text.trim(),
          qty: int.tryParse(qtyController.text.trim()) ?? 0,
          productType: 'SIMPLE',
          isStock: isStock.value,
          isActive: isActive.value,
          categoryIds: [categoryId],
        );
      } else {
        await _productRepository.createProduct(
          name: nameController.text.trim(),
          price: double.tryParse(priceController.text.trim()) ?? 0,
          sku: skuController.text.trim(),
          upc: upcController.text.trim(),
          imageUrl: imageUrlController.text.trim(),
          imageThumbUrl: imageThumbUrlController.text.trim(),
          description: descriptionController.text.trim(),
          qty: int.tryParse(qtyController.text.trim()) ?? 0,
          productType: 'SIMPLE',
          isStock: isStock.value,
          categoryIds: [categoryId],
        );
      }
      await loadInitialData();
      startCreate();
      Get.snackbar(
        'Produk tersimpan',
        'Data produk berhasil dikirim ke API.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menyimpan produk.';
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await _productRepository.deleteProduct(productId);
      await loadInitialData();
      if (selectedProductId.value == productId) {
        startCreate();
      }
      Get.snackbar(
        'Produk dihapus',
        'Data produk berhasil dihapus dari API.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menghapus produk.';
    }
  }

  Future<void> recalculatePrices() async {
    try {
      await _productRepository.recalculatePrices();
      Get.snackbar(
        'Recalculate selesai',
        'Permintaan hitung ulang harga berhasil dikirim.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await loadInitialData();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menjalankan recalculate price.';
    }
  }

  Future<void> loadProductDetail(int productId) async {
    try {
      selectedProductId.value = productId;
      selectedDetail.value = await _productRepository.getProductDetail(
        productId,
      );
      if (selectedDetail.value != null) {
        final detail = selectedDetail.value!;
        if (detail.variantGroups.isNotEmpty) {
          variantGroupId.value = detail.variantGroups.first.id;
        }
        if (detail.modifierGroups.isNotEmpty) {
          modifierGroupId.value = detail.modifierGroups.first.id;
        }
      }
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat detail produk.';
    }
  }

  void clearVariantForms() {
    variantGroupNameController.clear();
    variantGroupDisplayOrderController.text = '1';
    variantNameController.clear();
    variantAdditionalPriceController.text = '0';
    variantSkuController.clear();
    variantQtyController.text = '0';
    selectedVariantId.value = null;
    variantGroupRequired.value = false;
    variantIsStock.value = true;
    variantIsDefault.value = false;
  }

  void clearModifierForms() {
    modifierGroupNameController.clear();
    modifierGroupDisplayOrderController.text = '1';
    modifierGroupMinSelectController.text = '0';
    modifierGroupMaxSelectController.text = '1';
    modifierNameController.clear();
    modifierAdditionalPriceController.text = '0';
    selectedModifierId.value = null;
    modifierGroupRequired.value = false;
    modifierIsStock.value = false;
    modifierIsDefault.value = false;
  }

  void fillVariantGroup(VariantGroup group) {
    variantGroupId.value = group.id;
    variantGroupNameController.text = group.name;
    variantGroupDisplayOrderController.text = group.displayOrder.toString();
    variantGroupRequired.value = group.isRequired;
  }

  void fillVariant(VariantGroup group, VariantItem item) {
    variantGroupId.value = group.id;
    selectedVariantId.value = item.id;
    variantNameController.text = item.name;
    variantAdditionalPriceController.text = item.additionalPrice
        .toStringAsFixed(0);
    variantSkuController.text = item.sku;
    variantQtyController.text = item.qty.toString();
    variantIsStock.value = item.isStock;
    variantIsDefault.value = item.isDefault;
  }

  void fillModifierGroup(ModifierGroup group) {
    modifierGroupId.value = group.id;
    modifierGroupNameController.text = group.name;
    modifierGroupDisplayOrderController.text = group.displayOrder.toString();
    modifierGroupMinSelectController.text = group.minSelect.toString();
    modifierGroupMaxSelectController.text = group.maxSelect.toString();
    modifierGroupRequired.value = group.isRequired;
  }

  void fillModifier(ModifierGroup group, ModifierItem item) {
    modifierGroupId.value = group.id;
    selectedModifierId.value = item.id;
    modifierNameController.text = item.name;
    modifierAdditionalPriceController.text = item.additionalPrice
        .toStringAsFixed(0);
    modifierIsStock.value = item.isStock;
    modifierIsDefault.value = item.isDefault;
  }

  Future<void> saveVariantGroup() async {
    final productId = selectedProductId.value;
    if (productId == null) return;
    try {
      if (variantGroupId.value == null ||
          !(selectedDetail.value?.variantGroups.any(
                (group) => group.id == variantGroupId.value,
              ) ??
              false)) {
        final result = await _productRepository.addVariantGroup(
          productId: productId,
          name: variantGroupNameController.text.trim(),
          isRequired: variantGroupRequired.value,
          displayOrder:
              int.tryParse(variantGroupDisplayOrderController.text.trim()) ?? 1,
        );
        variantGroupId.value = result.id;
      } else {
        await _productRepository.updateVariantGroup(
          productId: productId,
          variantGroupId: variantGroupId.value!,
          name: variantGroupNameController.text.trim(),
          isRequired: variantGroupRequired.value,
          displayOrder:
              int.tryParse(variantGroupDisplayOrderController.text.trim()) ?? 1,
        );
      }
      await loadProductDetail(productId);
      Get.snackbar(
        'Variant Group',
        'Variant group berhasil disimpan.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menyimpan variant group.';
    }
  }

  Future<void> deleteCurrentVariantGroup() async {
    final productId = selectedProductId.value;
    final currentGroupId = variantGroupId.value;
    if (productId == null || currentGroupId == null) return;
    try {
      await _productRepository.deleteVariantGroup(productId, currentGroupId);
      await loadProductDetail(productId);
      clearVariantForms();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menghapus variant group.';
    }
  }

  Future<void> saveVariant() async {
    final productId = selectedProductId.value;
    final currentGroupId = variantGroupId.value;
    if (productId == null || currentGroupId == null) return;
    try {
      if (selectedVariantId.value == null) {
        await _productRepository.addVariant(
          productId: productId,
          variantGroupId: currentGroupId,
          name: variantNameController.text.trim(),
          additionalPrice:
              double.tryParse(variantAdditionalPriceController.text.trim()) ??
              0,
          sku: variantSkuController.text.trim(),
          isStock: variantIsStock.value,
          isDefault: variantIsDefault.value,
          qty: int.tryParse(variantQtyController.text.trim()) ?? 0,
        );
      } else {
        await _productRepository.updateVariant(
          productId: productId,
          variantId: selectedVariantId.value!,
          variantGroupId: currentGroupId,
          name: variantNameController.text.trim(),
          additionalPrice:
              double.tryParse(variantAdditionalPriceController.text.trim()) ??
              0,
          sku: variantSkuController.text.trim(),
          isStock: variantIsStock.value,
          isDefault: variantIsDefault.value,
          qty: int.tryParse(variantQtyController.text.trim()) ?? 0,
        );
      }
      await loadProductDetail(productId);
      clearVariantForms();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menyimpan variant.';
    }
  }

  Future<void> toggleVariantActive(VariantItem item, bool isActive) async {
    final productId = selectedProductId.value;
    if (productId == null) return;
    try {
      await _productRepository.setVariantActive(
        productId: productId,
        variantId: item.id,
        isActive: isActive,
      );
      await loadProductDetail(productId);
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal mengubah status variant.';
    }
  }

  Future<void> saveModifierGroup() async {
    final productId = selectedProductId.value;
    if (productId == null) return;
    try {
      if (modifierGroupId.value == null ||
          !(selectedDetail.value?.modifierGroups.any(
                (group) => group.id == modifierGroupId.value,
              ) ??
              false)) {
        final result = await _productRepository.addModifierGroup(
          productId: productId,
          name: modifierGroupNameController.text.trim(),
          isRequired: modifierGroupRequired.value,
          minSelect:
              int.tryParse(modifierGroupMinSelectController.text.trim()) ?? 0,
          maxSelect:
              int.tryParse(modifierGroupMaxSelectController.text.trim()) ?? 1,
          displayOrder:
              int.tryParse(modifierGroupDisplayOrderController.text.trim()) ??
              1,
        );
        modifierGroupId.value = result.id;
      } else {
        await _productRepository.updateModifierGroup(
          productId: productId,
          modifierGroupId: modifierGroupId.value!,
          name: modifierGroupNameController.text.trim(),
          isRequired: modifierGroupRequired.value,
          minSelect:
              int.tryParse(modifierGroupMinSelectController.text.trim()) ?? 0,
          maxSelect:
              int.tryParse(modifierGroupMaxSelectController.text.trim()) ?? 1,
          displayOrder:
              int.tryParse(modifierGroupDisplayOrderController.text.trim()) ??
              1,
        );
      }
      await loadProductDetail(productId);
      Get.snackbar(
        'Modifier Group',
        'Modifier group berhasil disimpan.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menyimpan modifier group.';
    }
  }

  Future<void> deleteCurrentModifierGroup() async {
    final productId = selectedProductId.value;
    final currentGroupId = modifierGroupId.value;
    if (productId == null || currentGroupId == null) return;
    try {
      await _productRepository.deleteModifierGroup(productId, currentGroupId);
      await loadProductDetail(productId);
      clearModifierForms();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menghapus modifier group.';
    }
  }

  Future<void> saveModifier() async {
    final productId = selectedProductId.value;
    final currentGroupId = modifierGroupId.value;
    if (productId == null || currentGroupId == null) return;
    try {
      if (selectedModifierId.value == null) {
        await _productRepository.addModifier(
          productId: productId,
          modifierGroupId: currentGroupId,
          name: modifierNameController.text.trim(),
          additionalPrice:
              double.tryParse(modifierAdditionalPriceController.text.trim()) ??
              0,
          isStock: modifierIsStock.value,
          isDefault: modifierIsDefault.value,
        );
      } else {
        await _productRepository.updateModifier(
          productId: productId,
          modifierId: selectedModifierId.value!,
          modifierGroupId: currentGroupId,
          name: modifierNameController.text.trim(),
          additionalPrice:
              double.tryParse(modifierAdditionalPriceController.text.trim()) ??
              0,
          isStock: modifierIsStock.value,
          isDefault: modifierIsDefault.value,
        );
      }
      await loadProductDetail(productId);
      clearModifierForms();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menyimpan modifier.';
    }
  }

  Future<void> toggleModifierActive(ModifierItem item, bool isActive) async {
    final productId = selectedProductId.value;
    if (productId == null) return;
    try {
      await _productRepository.setModifierActive(
        productId: productId,
        modifierId: item.id,
        isActive: isActive,
      );
      await loadProductDetail(productId);
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal mengubah status modifier.';
    }
  }
}
