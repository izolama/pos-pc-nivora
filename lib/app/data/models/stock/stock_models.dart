class StockMovementItem {
  const StockMovementItem({
    required this.productId,
    required this.qty,
    required this.movementType,
    required this.movementReason,
    required this.localDateTime,
  });

  final int productId;
  final int qty;
  final String movementType;
  final String movementReason;
  final String localDateTime;

  factory StockMovementItem.fromJson(Map<String, dynamic> json) {
    return StockMovementItem(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      movementType: json['movementType']?.toString() ?? '',
      movementReason: json['movementReason']?.toString() ?? '',
      localDateTime: json['localDateTime']?.toString() ?? '',
    );
  }
}
