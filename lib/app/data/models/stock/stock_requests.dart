class StockUpdateRequest {
  const StockUpdateRequest({
    required this.productId,
    required this.qty,
    required this.updateType,
  });

  final int productId;
  final int qty;
  final String updateType;

  Map<String, dynamic> toJson() {
    return {'productId': productId, 'qty': qty, 'updateType': updateType};
  }
}
