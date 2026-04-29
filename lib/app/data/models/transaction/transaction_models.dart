class TransactionSummaryItem {
  const TransactionSummaryItem({
    required this.id,
    required this.trxId,
    required this.code,
    required this.paymentMethod,
    required this.status,
    required this.totalAmount,
    required this.transactionDate,
    required this.transactionType,
    required this.queueNumber,
  });

  final int id;
  final String trxId;
  final String code;
  final String paymentMethod;
  final String status;
  final String totalAmount;
  final String transactionDate;
  final String transactionType;
  final String queueNumber;

  factory TransactionSummaryItem.fromJson(Map<String, dynamic> json) {
    return TransactionSummaryItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      trxId: json['trxId']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      totalAmount: json['totalAmount']?.toString() ?? '0',
      transactionDate: json['transactionDate']?.toString() ?? '',
      transactionType: json['transactionType']?.toString() ?? '',
      queueNumber: json['queueNumber']?.toString() ?? '',
    );
  }
}

class TransactionDetailItem {
  const TransactionDetailItem({
    required this.productName,
    required this.price,
    required this.qty,
    required this.totalPrice,
  });

  final String productName;
  final String price;
  final int qty;
  final String totalPrice;

  factory TransactionDetailItem.fromJson(Map<String, dynamic> json) {
    return TransactionDetailItem(
      productName: json['productName']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      qty: (json['qty'] as num?)?.toInt() ?? 0,
      totalPrice: json['totalPrice']?.toString() ?? '0',
    );
  }
}

class TransactionDetail {
  const TransactionDetail({
    required this.transactionId,
    required this.code,
    required this.status,
    required this.paymentMethod,
    required this.subTotal,
    required this.totalTax,
    required this.totalServiceCharge,
    required this.totalRounding,
    required this.totalAmount,
    required this.cashTendered,
    required this.cashChange,
    required this.transactionDate,
    required this.queueNumber,
    required this.notes,
    required this.items,
  });

  final int transactionId;
  final String code;
  final String status;
  final String paymentMethod;
  final String subTotal;
  final String totalTax;
  final String totalServiceCharge;
  final String totalRounding;
  final String totalAmount;
  final String cashTendered;
  final String cashChange;
  final String transactionDate;
  final String queueNumber;
  final String notes;
  final List<TransactionDetailItem> items;

  factory TransactionDetail.fromJson(Map<String, dynamic> json) {
    return TransactionDetail(
      transactionId: (json['transactionId'] as num?)?.toInt() ?? 0,
      code: json['code']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      subTotal: json['subTotal']?.toString() ?? '0',
      totalTax: json['totalTax']?.toString() ?? '0',
      totalServiceCharge: json['totalServiceCharge']?.toString() ?? '0',
      totalRounding: json['totalRounding']?.toString() ?? '0',
      totalAmount: json['totalAmount']?.toString() ?? '0',
      cashTendered: json['cashTendered']?.toString() ?? '0',
      cashChange: json['cashChange']?.toString() ?? '0',
      transactionDate: json['transactionDate']?.toString() ?? '',
      queueNumber: json['queueNumber']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      items:
          ((json['transactionItems'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(TransactionDetailItem.fromJson)
              .toList(),
    );
  }
}
