import '../config/api_endpoints.dart';
import '../models/api/api_response.dart';
import '../models/transaction/payment_method_models.dart';
import '../models/transaction/transaction_models.dart';
import '../models/transaction/transaction_mutation_result.dart';
import '../models/transaction/transaction_requests.dart';
import '../network/api_client.dart';

class TransactionApiService {
  TransactionApiService({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<List<TransactionSummaryItem>> getTransactions({
    String startDate = '2026-01-01',
    String endDate = '2026-12-31',
    int page = 0,
    int size = 10,
  }) async {
    final json = await _apiClient.get(
      ApiEndpoints.transactionList,
      queryParameters: {
        'page': page,
        'size': size,
        'startDate': startDate,
        'endDate': endDate,
        'sortBy': 'transactionDate',
        'sortType': 'DESC',
      },
    );
    final response = ApiResponse<List<TransactionSummaryItem>>.fromJson(
      json,
      (raw) =>
          ((raw as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(TransactionSummaryItem.fromJson)
              .toList(),
    );
    return response.data;
  }

  Future<TransactionDetail> getTransactionDetail(int transactionId) async {
    final json = await _apiClient.get(
      ApiEndpoints.transactionDetail(transactionId),
    );
    final response = ApiResponse<TransactionDetail>.fromJson(
      json,
      (raw) => TransactionDetail.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<TransactionMutationResult> createTransaction(
    CreateTransactionRequest request,
  ) async {
    final json = await _apiClient.post(
      ApiEndpoints.transactionCreate,
      body: request.toJson(),
    );
    final response = ApiResponse<TransactionMutationResult>.fromJson(
      json,
      (raw) => TransactionMutationResult.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }

  Future<void> initiatePayment(
    String merchantTrxId,
    InitiatePaymentRequest request,
  ) async {
    await _apiClient.put(
      ApiEndpoints.initiatePayment(merchantTrxId),
      body: request.toJson(),
    );
  }

  Future<void> updateTransactionPayment(
    String merchantTrxId,
    UpdateTransactionPaymentRequest request,
  ) async {
    await _apiClient.put(
      ApiEndpoints.transactionUpdate(merchantTrxId),
      body: request.toJson(),
    );
  }

  Future<PaymentMethodGroup> getPaymentMethods() async {
    final json = await _apiClient.get(ApiEndpoints.paymentMethodList);
    final response = ApiResponse<PaymentMethodGroup>.fromJson(
      json,
      (raw) => PaymentMethodGroup.fromJson(raw as Map<String, dynamic>),
    );
    return response.data;
  }
}
