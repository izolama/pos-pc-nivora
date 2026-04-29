class PaymentSettingRequest {
  const PaymentSettingRequest({
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

  final int? paymentSettingId;
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

  Map<String, dynamic> toJson() {
    return {
      if (paymentSettingId != null) 'paymentSettingId': paymentSettingId,
      'isPriceIncludeTax': isPriceIncludeTax,
      'isRounding': isRounding,
      'roundingTarget': roundingTarget,
      'roundingType': roundingType,
      'isServiceCharge': isServiceCharge,
      'serviceChargePercentage': serviceChargePercentage,
      'serviceChargeAmount': serviceChargeAmount,
      'isTax': isTax,
      'taxPercentage': taxPercentage,
      'taxName': taxName,
    };
  }
}
