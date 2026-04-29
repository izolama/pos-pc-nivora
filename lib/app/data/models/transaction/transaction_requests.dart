class CreateTransactionItemRequest {
  const CreateTransactionItemRequest({
    required this.productId,
    required this.productName,
    required this.price,
    required this.qty,
    required this.totalPrice,
  });

  final int productId;
  final String productName;
  final String price;
  final int qty;
  final String totalPrice;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'qty': qty,
      'totalPrice': totalPrice,
      'taxId': null,
      'taxAmount': null,
    };
  }
}

class CreateTransactionRequest {
  const CreateTransactionRequest({
    required this.subTotal,
    required this.totalServiceCharge,
    required this.totalTax,
    required this.totalRounding,
    required this.totalAmount,
    required this.paymentMethod,
    required this.cashTendered,
    required this.cashChange,
    required this.priceIncludeTax,
    required this.queueNumber,
    required this.notes,
    required this.transactionItems,
  });

  final String subTotal;
  final String totalServiceCharge;
  final String totalTax;
  final String totalRounding;
  final String totalAmount;
  final String paymentMethod;
  final String cashTendered;
  final String cashChange;
  final bool priceIncludeTax;
  final int queueNumber;
  final String notes;
  final List<CreateTransactionItemRequest> transactionItems;

  Map<String, dynamic> toJson() {
    return {
      'subTotal': subTotal,
      'totalServiceCharge': totalServiceCharge,
      'totalTax': totalTax,
      'totalRounding': totalRounding,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'cashTendered': cashTendered,
      'cashChange': cashChange,
      'priceIncludeTax': priceIncludeTax,
      'queueNumber': queueNumber,
      'notes': notes,
      'transactionItems':
          transactionItems.map((item) => item.toJson()).toList(),
    };
  }
}

class InitiatePaymentRequest {
  const InitiatePaymentRequest({
    required this.paymentMethod,
    required this.totalAmount,
    required this.paymentTrxId,
    required this.qrContent,
  });

  final String paymentMethod;
  final String totalAmount;
  final String paymentTrxId;
  final String qrContent;

  Map<String, dynamic> toJson() {
    return {
      'paymentMethod': paymentMethod,
      'totalAmount': totalAmount,
      'paymentTrxId': paymentTrxId,
      'additionalInfo': {'qrContent': qrContent},
    };
  }
}

class UpdateTransactionPaymentRequest {
  const UpdateTransactionPaymentRequest({
    required this.paymentTrxId,
    required this.paymentMethod,
    required this.amountPaid,
    required this.status,
    required this.paymentReference,
    required this.paymentDate,
  });

  final String paymentTrxId;
  final String paymentMethod;
  final double amountPaid;
  final String status;
  final String paymentReference;
  final String paymentDate;

  Map<String, dynamic> toJson() {
    return {
      'paymentTrxId': paymentTrxId,
      'paymentMethod': paymentMethod,
      'amountPaid': amountPaid,
      'status': status,
      'paymentReference': paymentReference,
      'paymentDate': paymentDate,
    };
  }
}
