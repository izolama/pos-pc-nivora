class TransactionMutationResult {
  const TransactionMutationResult({
    required this.id,
    required this.trxId,
    required this.queueNumber,
  });

  final int id;
  final String trxId;
  final String queueNumber;

  factory TransactionMutationResult.fromJson(Map<String, dynamic> json) {
    return TransactionMutationResult(
      id: (json['id'] as num?)?.toInt() ?? 0,
      trxId: json['trxId']?.toString() ?? '',
      queueNumber: json['queueNumber']?.toString() ?? '',
    );
  }
}
