import '../config/api_endpoints.dart';
import '../models/api/api_response.dart';
import '../models/stock/stock_models.dart';
import '../models/stock/stock_requests.dart';
import '../network/api_client.dart';

class StockApiService {
  StockApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<void> updateStock(StockUpdateRequest request) async {
    await _apiClient.put(ApiEndpoints.stockUpdate, body: request.toJson());
  }

  Future<List<StockMovementItem>> getStockMovements({
    required int productId,
    String startDate = '2026-01-01',
    String endDate = '2026-12-31',
  }) async {
    final json = await _apiClient.get(
      ApiEndpoints.stockMovementList,
      queryParameters: {
        'productId': productId,
        'startDate': startDate,
        'endDate': endDate,
      },
    );
    final response = ApiResponse<List<StockMovementItem>>.fromJson(
      json,
      (raw) =>
          ((raw as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(StockMovementItem.fromJson)
              .toList(),
    );
    return response.data;
  }
}
