class PaymentSettingModel {
  const PaymentSettingModel({
    required this.paymentSettingId,
    required this.isPriceIncludeTax,
    required this.isRounding,
    required this.roundingTarget,
    required this.roundingType,
    required this.isServiceCharge,
    required this.serviceChargePercentage,
    required this.serviceChargeAmount,
    required this.isTax,
    required this.taxPercentage,
    required this.taxName,
  });

  final int paymentSettingId;
  final bool isPriceIncludeTax;
  final bool isRounding;
  final int roundingTarget;
  final String roundingType;
  final bool isServiceCharge;
  final double serviceChargePercentage;
  final double serviceChargeAmount;
  final bool isTax;
  final double taxPercentage;
  final String taxName;

  factory PaymentSettingModel.fromJson(Map<String, dynamic> json) {
    return PaymentSettingModel(
      paymentSettingId: (json['paymentSettingId'] as num?)?.toInt() ?? 0,
      isPriceIncludeTax: json['isPriceIncludeTax'] as bool? ?? false,
      isRounding: json['isRounding'] as bool? ?? false,
      roundingTarget: (json['roundingTarget'] as num?)?.toInt() ?? 0,
      roundingType: json['roundingType']?.toString() ?? 'NONE',
      isServiceCharge: json['isServiceCharge'] as bool? ?? false,
      serviceChargePercentage:
          (json['serviceChargePercentage'] as num?)?.toDouble() ?? 0,
      serviceChargeAmount:
          (json['serviceChargeAmount'] as num?)?.toDouble() ?? 0,
      isTax: json['isTax'] as bool? ?? false,
      taxPercentage: (json['taxPercentage'] as num?)?.toDouble() ?? 0,
      taxName: json['taxName']?.toString() ?? '',
    );
  }
}
