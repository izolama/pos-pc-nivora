import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/exceptions/app_exception.dart';
import '../../../data/models/transaction/cart_item_model.dart';
import '../../../data/models/product/product_item.dart';
import '../../../data/models/transaction/payment_method_models.dart';
import '../../../data/models/transaction/transaction_models.dart';
import '../../../data/models/transaction/transaction_requests.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/transaction_repository.dart';
import '../../payment/controllers/payment_setting_controller.dart';

class TransactionController extends GetxController {
  TransactionController({
    required TransactionRepository transactionRepository,
    required ProductRepository productRepository,
  }) : _transactionRepository = transactionRepository,
       _productRepository = productRepository;

  final TransactionRepository _transactionRepository;
  final ProductRepository _productRepository;
  final PaymentSettingController paymentSettingController = Get.find();

  final transactions = <TransactionSummaryItem>[].obs;
  final products = <ProductItem>[].obs;
  final paymentMethods = <PaymentMethodItem>[].obs;
  final cartItems = <CartItemModel>[].obs;
  final selectedDetail = Rxn<TransactionDetail>();
  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final errorMessage = ''.obs;

  final quantityController = TextEditingController(text: '1');
  final notesController = TextEditingController();
  final paymentTrxIdController = TextEditingController(text: 'CZ-TRX-ID-001');
  final paymentReferenceController = TextEditingController(
    text: 'REF-QRIS-12345',
  );
  final qrContentController = TextEditingController(
    text:
        '00020101021226600014ID.CO.CASHLEZ.WWW011893600898002087690102150000870269010220303UBE5144',
  );

  final selectedProductId = RxnInt();
  final selectedPaymentCode = RxnString();
  final selectedTransactionId = RxnInt();

  double get cartSubtotal =>
      cartItems.fold(0, (total, item) => total + item.total);

  double get serviceChargeAmount {
    final setting = paymentSettingController.currentSetting;
    if (!setting.isServiceCharge) {
      return 0;
    }
    if (setting.serviceChargeAmount > 0) {
      return setting.serviceChargeAmount;
    }
    return cartSubtotal * (setting.serviceChargePercentage / 100);
  }

  double get totalBeforeTax {
    return cartSubtotal + serviceChargeAmount;
  }

  double get taxAmount {
    final setting = paymentSettingController.currentSetting;
    if (!setting.isTax || setting.taxPercentage <= 0) {
      return 0;
    }
    if (setting.isPriceIncludeTax) {
      return totalBeforeTax *
          (setting.taxPercentage / (100 + setting.taxPercentage));
    }
    return totalBeforeTax * (setting.taxPercentage / 100);
  }

  double get totalBeforeRounding {
    final setting = paymentSettingController.currentSetting;
    if (setting.isPriceIncludeTax) {
      return totalBeforeTax;
    }
    return totalBeforeTax + taxAmount;
  }

  double get roundingAmount {
    final setting = paymentSettingController.currentSetting;
    if (!setting.isRounding || setting.roundingTarget <= 0) {
      return 0;
    }

    final rawTotal = totalBeforeRounding;
    final target = setting.roundingTarget.toDouble();
    switch (setting.roundingType) {
      case 'UP':
        return ((rawTotal / target).ceilToDouble() * target) - rawTotal;
      case 'DOWN':
        return ((rawTotal / target).floorToDouble() * target) - rawTotal;
      default:
        return 0;
    }
  }

  double get grandTotal => totalBeforeRounding + roundingAmount;

  @override
  void onClose() {
    quantityController.dispose();
    notesController.dispose();
    paymentTrxIdController.dispose();
    paymentReferenceController.dispose();
    qrContentController.dispose();
    super.onClose();
  }

  Future<void> loadInitialData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      products.assignAll(await _productRepository.getProducts(size: 50));
      final methods = await _transactionRepository.getPaymentMethods();
      paymentMethods.assignAll(methods.all);
      if (products.isNotEmpty) {
        selectedProductId.value ??= products.first.id;
      }
      if (paymentMethods.isNotEmpty) {
        selectedPaymentCode.value ??= paymentMethods.first.code;
      }
      transactions.assignAll(await _transactionRepository.getTransactions());
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat modul transaksi.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTransactions() async {
    try {
      transactions.assignAll(await _transactionRepository.getTransactions());
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat daftar transaksi.';
    }
  }

  Future<void> loadDetail(int transactionId) async {
    selectedTransactionId.value = transactionId;
    try {
      selectedDetail.value = await _transactionRepository.getTransactionDetail(
        transactionId,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat detail transaksi.';
    }
  }

  Future<void> createTransaction() async {
    final paymentMethod = selectedPaymentCode.value;
    if (cartItems.isEmpty || paymentMethod == null) {
      errorMessage.value =
          'Cart masih kosong atau payment method belum dipilih.';
      return;
    }
    final subtotal = cartSubtotal.toStringAsFixed(0);
    final totalServiceCharge = serviceChargeAmount.toStringAsFixed(0);
    final totalTax = taxAmount.toStringAsFixed(0);
    final totalRounding = roundingAmount.toStringAsFixed(0);
    final totalAmount = grandTotal.toStringAsFixed(0);
    final setting = paymentSettingController.currentSetting;

    isSubmitting.value = true;
    errorMessage.value = '';
    try {
      final result = await _transactionRepository.createTransaction(
        CreateTransactionRequest(
          subTotal: subtotal,
          totalServiceCharge: totalServiceCharge,
          totalTax: totalTax,
          totalRounding: totalRounding,
          totalAmount: totalAmount,
          paymentMethod: paymentMethod,
          cashTendered: totalAmount,
          cashChange: '0',
          priceIncludeTax: setting.isPriceIncludeTax,
          queueNumber: 1,
          notes: notesController.text.trim(),
          transactionItems:
              cartItems
                  .map(
                    (item) => CreateTransactionItemRequest(
                      productId: item.productId,
                      productName: item.productName,
                      price: item.price.toStringAsFixed(0),
                      qty: item.qty,
                      totalPrice: item.total.toStringAsFixed(0),
                    ),
                  )
                  .toList(),
        ),
      );
      cartItems.clear();
      quantityController.text = '1';
      notesController.clear();
      await refreshTransactions();
      await loadDetail(result.id);
      Get.snackbar(
        'Transaksi dibuat',
        'TRX ${result.trxId} berhasil dibuat.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal membuat transaksi.';
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> initiatePayment() async {
    final detail = selectedDetail.value;
    final paymentMethod = selectedPaymentCode.value;
    if (detail == null || paymentMethod == null) {
      errorMessage.value = 'Pilih transaksi detail dan payment method.';
      return;
    }

    try {
      await _transactionRepository.initiatePayment(
        detail.code,
        InitiatePaymentRequest(
          paymentMethod: paymentMethod,
          totalAmount: detail.totalAmount,
          paymentTrxId: paymentTrxIdController.text.trim(),
          qrContent: qrContentController.text.trim(),
        ),
      );
      Get.snackbar(
        'Initiate payment',
        'Permintaan initiate payment berhasil dikirim.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await refreshTransactions();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal initiate payment.';
    }
  }

  Future<void> markTransactionPaid() async {
    final detail = selectedDetail.value;
    final paymentMethod = selectedPaymentCode.value;
    if (detail == null || paymentMethod == null) {
      errorMessage.value = 'Pilih transaksi detail dan payment method.';
      return;
    }

    try {
      await _transactionRepository.updateTransactionPayment(
        detail.code,
        UpdateTransactionPaymentRequest(
          paymentTrxId: paymentTrxIdController.text.trim(),
          paymentMethod: paymentMethod,
          amountPaid: double.tryParse(detail.totalAmount) ?? 0,
          status: 'PAID',
          paymentReference: paymentReferenceController.text.trim(),
          paymentDate: DateTime.now().toIso8601String(),
        ),
      );
      Get.snackbar(
        'Status pembayaran',
        'Transaksi berhasil diupdate menjadi PAID.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await refreshTransactions();
      await loadDetail(detail.transactionId);
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal update pembayaran transaksi.';
    }
  }

  void addSelectedProductToCart() {
    ProductItem? product;
    for (final item in products) {
      if (item.id == selectedProductId.value) {
        product = item;
        break;
      }
    }
    final qty = int.tryParse(quantityController.text.trim()) ?? 1;
    if (product == null || qty <= 0) {
      errorMessage.value = 'Pilih produk dan qty yang valid.';
      return;
    }

    final existingIndex = cartItems.indexWhere(
      (item) => item.productId == product!.id,
    );
    if (existingIndex >= 0) {
      final existing = cartItems[existingIndex];
      cartItems[existingIndex] = existing.copyWith(qty: existing.qty + qty);
    } else {
      cartItems.add(CartItemModel.fromProduct(product, qty));
    }
    quantityController.text = '1';
    errorMessage.value = '';
  }

  void incrementCartQty(int productId) {
    final index = cartItems.indexWhere((item) => item.productId == productId);
    if (index < 0) return;
    final item = cartItems[index];
    cartItems[index] = item.copyWith(qty: item.qty + 1);
  }

  void decrementCartQty(int productId) {
    final index = cartItems.indexWhere((item) => item.productId == productId);
    if (index < 0) return;
    final item = cartItems[index];
    if (item.qty <= 1) {
      cartItems.removeAt(index);
      return;
    }
    cartItems[index] = item.copyWith(qty: item.qty - 1);
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.productId == productId);
  }

  void clearCart() {
    cartItems.clear();
  }
}
