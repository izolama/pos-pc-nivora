import '../models/stock/stock_models.dart';
import '../models/stock/stock_requests.dart';
import '../services/stock_api_service.dart';

class StockRepository {
  StockRepository({required StockApiService service}) : _service = service;

  final StockApiService _service;

  Future<void> updateStock({
    required int productId,
    required int qty,
    required String updateType,
  }) {
    return _service.updateStock(
      StockUpdateRequest(
        productId: productId,
        qty: qty,
        updateType: updateType,
      ),
    );
  }

  Future<List<StockMovementItem>> getStockMovements({required int productId}) {
    return _service.getStockMovements(productId: productId);
  }
}
