import '../models/transaction/payment_method_models.dart';
import '../models/transaction/transaction_models.dart';
import '../models/transaction/transaction_mutation_result.dart';
import '../models/transaction/transaction_requests.dart';
import '../services/transaction_api_service.dart';

class TransactionRepository {
  TransactionRepository({required TransactionApiService service})
    : _service = service;

  final TransactionApiService _service;

  Future<List<TransactionSummaryItem>> getTransactions() {
    return _service.getTransactions();
  }

  Future<TransactionDetail> getTransactionDetail(int transactionId) {
    return _service.getTransactionDetail(transactionId);
  }

  Future<TransactionMutationResult> createTransaction(
    CreateTransactionRequest request,
  ) {
    return _service.createTransaction(request);
  }

  Future<void> initiatePayment(
    String merchantTrxId,
    InitiatePaymentRequest request,
  ) {
    return _service.initiatePayment(merchantTrxId, request);
  }

  Future<void> updateTransactionPayment(
    String merchantTrxId,
    UpdateTransactionPaymentRequest request,
  ) {
    return _service.updateTransactionPayment(merchantTrxId, request);
  }

  Future<PaymentMethodGroup> getPaymentMethods() {
    return _service.getPaymentMethods();
  }
}
