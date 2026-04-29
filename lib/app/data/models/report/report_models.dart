class ReportProductItem {
  const ReportProductItem({
    required this.productName,
    required this.totalSaleItems,
  });

  final String productName;
  final int totalSaleItems;

  factory ReportProductItem.fromJson(Map<String, dynamic> json) {
    return ReportProductItem(
      productName: json['productName']?.toString() ?? '',
      totalSaleItems: (json['totalSaleItems'] as num?)?.toInt() ?? 0,
    );
  }
}

class ReportPaymentItem {
  const ReportPaymentItem({
    required this.paymentName,
    required this.totalTransactions,
    required this.totalAmountTransactions,
  });

  final String paymentName;
  final int totalTransactions;
  final double totalAmountTransactions;

  factory ReportPaymentItem.fromJson(Map<String, dynamic> json) {
    return ReportPaymentItem(
      paymentName: json['paymentName']?.toString() ?? '',
      totalTransactions: (json['totalTransactions'] as num?)?.toInt() ?? 0,
      totalAmountTransactions:
          (json['totalAmountTransactions'] as num?)?.toDouble() ?? 0,
    );
  }
}

class SummaryReportModel {
  const SummaryReportModel({
    required this.productList,
    required this.paymentListInternal,
    required this.paymentListExternal,
  });

  final List<ReportProductItem> productList;
  final List<ReportPaymentItem> paymentListInternal;
  final List<ReportPaymentItem> paymentListExternal;

  factory SummaryReportModel.fromJson(Map<String, dynamic> json) {
    return SummaryReportModel(
      productList:
          ((json['productList'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(ReportProductItem.fromJson)
              .toList(),
      paymentListInternal:
          ((json['paymentListInternal'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(ReportPaymentItem.fromJson)
              .toList(),
      paymentListExternal:
          ((json['paymentListExternal'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(ReportPaymentItem.fromJson)
              .toList(),
    );
  }
}
