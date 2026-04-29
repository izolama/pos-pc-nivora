import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/exceptions/app_exception.dart';
import '../../../data/models/payment/payment_setting_model.dart';
import '../../../data/models/payment/payment_setting_request.dart';
import '../../../data/repositories/payment_setting_repository.dart';

class PaymentSettingController extends GetxController {
  PaymentSettingController({required PaymentSettingRepository repository})
    : _repository = repository;

  final PaymentSettingRepository _repository;

  final taxNameController = TextEditingController();
  final taxPercentageController = TextEditingController(text: '0');
  final serviceChargePercentageController = TextEditingController(text: '0');
  final serviceChargeAmountController = TextEditingController(text: '0');
  final roundingTargetController = TextEditingController(text: '0');

  final isPriceIncludeTax = false.obs;
  final isRounding = false.obs;
  final roundingType = 'NONE'.obs;
  final isServiceCharge = false.obs;
  final isTax = true.obs;
  final paymentSettingId = RxnInt();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  PaymentSettingModel get currentSetting {
    return PaymentSettingModel(
      paymentSettingId: paymentSettingId.value ?? 0,
      isPriceIncludeTax: isPriceIncludeTax.value,
      isRounding: isRounding.value,
      roundingTarget: int.tryParse(roundingTargetController.text.trim()) ?? 0,
      roundingType: roundingType.value,
      isServiceCharge: isServiceCharge.value,
      serviceChargePercentage:
          double.tryParse(serviceChargePercentageController.text.trim()) ?? 0,
      serviceChargeAmount:
          double.tryParse(serviceChargeAmountController.text.trim()) ?? 0,
      isTax: isTax.value,
      taxPercentage: double.tryParse(taxPercentageController.text.trim()) ?? 0,
      taxName: taxNameController.text.trim(),
    );
  }

  @override
  void onClose() {
    taxNameController.dispose();
    taxPercentageController.dispose();
    serviceChargePercentageController.dispose();
    serviceChargeAmountController.dispose();
    roundingTargetController.dispose();
    super.onClose();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final setting = await _repository.getPaymentSetting();
      paymentSettingId.value = setting.paymentSettingId;
      isPriceIncludeTax.value = setting.isPriceIncludeTax;
      isRounding.value = setting.isRounding;
      roundingTargetController.text = setting.roundingTarget.toString();
      roundingType.value = setting.roundingType;
      isServiceCharge.value = setting.isServiceCharge;
      serviceChargePercentageController.text = setting.serviceChargePercentage
          .toStringAsFixed(0);
      serviceChargeAmountController.text = setting.serviceChargeAmount
          .toStringAsFixed(0);
      isTax.value = setting.isTax;
      taxPercentageController.text = setting.taxPercentage.toStringAsFixed(0);
      taxNameController.text = setting.taxName;
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal memuat payment setting.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> save() async {
    try {
      await _repository.savePaymentSetting(
        PaymentSettingRequest(
          paymentSettingId: paymentSettingId.value,
          isPriceIncludeTax: isPriceIncludeTax.value,
          isRounding: isRounding.value,
          roundingTarget:
              int.tryParse(roundingTargetController.text.trim()) ?? 0,
          roundingType: roundingType.value,
          isServiceCharge: isServiceCharge.value,
          serviceChargePercentage:
              double.tryParse(serviceChargePercentageController.text.trim()) ??
              0,
          serviceChargeAmount:
              double.tryParse(serviceChargeAmountController.text.trim()) ?? 0,
          isTax: isTax.value,
          taxPercentage:
              double.tryParse(taxPercentageController.text.trim()) ?? 0,
          taxName: taxNameController.text.trim(),
        ),
      );
      Get.snackbar(
        'Payment setting',
        'Setting berhasil disimpan.',
        snackPosition: SnackPosition.BOTTOM,
      );
      await load();
    } on AppException catch (error) {
      errorMessage.value = error.message;
    } catch (_) {
      errorMessage.value = 'Gagal menyimpan payment setting.';
    }
  }
}
