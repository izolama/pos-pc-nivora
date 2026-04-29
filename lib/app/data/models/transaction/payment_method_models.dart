class PaymentMethodItem {
  const PaymentMethodItem({
    required this.code,
    required this.name,
    required this.category,
    required this.paymentType,
    required this.provider,
  });

  final String code;
  final String name;
  final String category;
  final String paymentType;
  final String provider;

  factory PaymentMethodItem.fromJson(Map<String, dynamic> json) {
    return PaymentMethodItem(
      code: json['code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      paymentType: json['paymentType']?.toString() ?? '',
      provider: json['provider']?.toString() ?? '',
    );
  }
}

class PaymentMethodGroup {
  const PaymentMethodGroup({
    required this.internalPayments,
    required this.externalPayments,
  });

  final List<PaymentMethodItem> internalPayments;
  final List<PaymentMethodItem> externalPayments;

  List<PaymentMethodItem> get all => [...internalPayments, ...externalPayments];

  factory PaymentMethodGroup.fromJson(Map<String, dynamic> json) {
    return PaymentMethodGroup(
      internalPayments:
          ((json['internalPayments'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(PaymentMethodItem.fromJson)
              .toList(),
      externalPayments:
          ((json['externalPayments'] as List?) ?? [])
              .whereType<Map<String, dynamic>>()
              .map(PaymentMethodItem.fromJson)
              .toList(),
    );
  }
}
