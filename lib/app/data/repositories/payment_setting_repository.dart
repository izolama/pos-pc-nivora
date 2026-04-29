import '../models/payment/payment_setting_model.dart';
import '../models/payment/payment_setting_request.dart';
import '../services/payment_setting_api_service.dart';

class PaymentSettingRepository {
  PaymentSettingRepository({required PaymentSettingApiService service})
    : _service = service;

  final PaymentSettingApiService _service;

  Future<PaymentSettingModel> getPaymentSetting() {
    return _service.getPaymentSetting();
  }

  Future<void> savePaymentSetting(PaymentSettingRequest request) async {
    if ((request.paymentSettingId ?? 0) > 0) {
      await _service.updatePaymentSetting(request);
      return;
    }
    await _service.createPaymentSetting(request);
  }
}
