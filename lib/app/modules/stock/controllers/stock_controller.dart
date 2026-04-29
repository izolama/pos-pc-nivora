import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/exceptions/app_exception.dart';
import '../../../data/models/product/product_item.dart';
import '../../../data/models/stock/stock_models.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/stock_repository.dart';

class StockController extends GetxController {
  StockController({
    required StockRepository stockRepository,
    required ProductRepository productRepository,
  }) : _stockRepository = stockRepository,
       _productRepository = productRepository;

  final StockRepository _stockRepository;
  final ProductRepository _productRepository;

  final products = <ProductItem>[].obs;
  final movements = <StockMovementItem>[].obs;
  final selectedProductId = RxnInt();
  final updateType = 'ADD'.obs;
  final qtyController = TextEditingController(text: '1');
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onClose() {
    qtyController.dispose();
    super.onClose();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      products.assignAll(await _productRepository.getProducts(size: 50));
      if (products.isNotEmpty) {
        selectedProductId.value ??= products.first.id;
        await loadMovements();
      }
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat data stock.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMovements() async {
    final productId = selectedProductId.value;
    if (productId == null) return;
    try {
      movements.assignAll(
        await _stockRepository.getStockMovements(productId: productId),
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat stock movement.';
    }
  }

  Future<void> updateStock() async {
    final productId = selectedProductId.value;
    if (productId == null) return;
    try {
      await _stockRepository.updateStock(
        productId: productId,
        qty: int.tryParse(qtyController.text.trim()) ?? 0,
        updateType: updateType.value,
      );
      await loadMovements();
      Get.snackbar(
        'Stock updated',
        'Perubahan stock berhasil dikirim.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal update stock.';
    }
  }
}
