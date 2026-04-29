import '../config/api_endpoints.dart';
import '../models/api/api_response.dart';
import '../models/payment/payment_setting_model.dart';
import '../models/payment/payment_setting_request.dart';
import '../network/api_client.dart';

class PaymentSettingApiService {
  PaymentSettingApiService({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<PaymentSettingModel> getPaymentSetting() async {
    final json = await _apiClient.get(ApiEndpoints.paymentSetting);
    final response = ApiResponse<PaymentSettingModel>.fromJson(
      json,
      (raw) => PaymentSettingModel.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<void> createPaymentSetting(PaymentSettingRequest request) async {
    await _apiClient.post(
      ApiEndpoints.paymentSettingCreate,
      body: request.toJson(),
    );
  }

  Future<void> updatePaymentSetting(PaymentSettingRequest request) async {
    await _apiClient.put(
      ApiEndpoints.paymentSettingUpdate,
      body: request.toJson(),
    );
  }
}
