import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TransactionManagementView extends GetView<TransactionController> {
  const TransactionManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD8E3ED)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Transaksi',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : controller.loadInitialData,
                  child: const Text('Refresh'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (controller.errorMessage.value.isNotEmpty)
              _ErrorBox(message: controller.errorMessage.value),
            if (controller.errorMessage.value.isNotEmpty)
              const SizedBox(height: 12),
            _TransactionForm(controller: controller),
            const SizedBox(height: 18),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child:
                        controller.isLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : _TransactionList(controller: controller),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _TransactionDetailPanel(controller: controller),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionForm extends StatelessWidget {
  const _TransactionForm({required this.controller});

  final TransactionController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                value: controller.selectedProductId.value,
                items:
                    controller.products
                        .map(
                          (item) => DropdownMenuItem<int>(
                            value: item.id,
                            child: Text(item.name),
                          ),
                        )
                        .toList(),
                onChanged:
                    (value) => controller.selectedProductId.value = value,
                decoration: const InputDecoration(
                  labelText: 'Produk',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: controller.selectedPaymentCode.value,
                items:
                    controller.paymentMethods
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item.code,
                            child: Text('${item.name} (${item.code})'),
                          ),
                        )
                        .toList(),
                onChanged:
                    (value) => controller.selectedPaymentCode.value = value,
                decoration: const InputDecoration(
                  labelText: 'Payment method',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller.quantityController,
                decoration: const InputDecoration(
                  labelText: 'Qty',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: controller.addSelectedProductToCart,
              child: const Text('Add to Cart'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.notesController,
          decoration: const InputDecoration(
            labelText: 'Notes',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        _CartPanel(controller: controller),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed:
                    controller.cartItems.isEmpty ? null : controller.clearCart,
                child: const Text('Clear Cart'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed:
                    controller.isSubmitting.value
                        ? null
                        : controller.createTransaction,
                child: Text(
                  controller.isSubmitting.value
                      ? 'Memproses...'
                      : 'Create Transaction',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CartPanel extends StatelessWidget {
  const _CartPanel({required this.controller});

  final TransactionController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD7E0EA)),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Cart',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  'Subtotal: ${controller.cartSubtotal.toStringAsFixed(0)}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _CalcChip(
                  label: 'Service',
                  value: controller.serviceChargeAmount.toStringAsFixed(0),
                ),
                _CalcChip(
                  label: 'Tax',
                  value: controller.taxAmount.toStringAsFixed(0),
                ),
                _CalcChip(
                  label: 'Rounding',
                  value: controller.roundingAmount.toStringAsFixed(0),
                ),
                _CalcChip(
                  label: 'Grand Total',
                  value: controller.grandTotal.toStringAsFixed(0),
                  emphasize: true,
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (controller.cartItems.isEmpty)
              const Text('Belum ada item di cart.')
            else
              ...controller.cartItems.map(
                (item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.productName),
                  subtitle: Text(
                    '${item.price.toStringAsFixed(0)} x ${item.qty} = ${item.total.toStringAsFixed(0)}',
                  ),
                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      IconButton(
                        onPressed:
                            () => controller.decrementCartQty(item.productId),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      IconButton(
                        onPressed:
                            () => controller.incrementCartQty(item.productId),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                      IconButton(
                        onPressed:
                            () => controller.removeFromCart(item.productId),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CalcChip extends StatelessWidget {
  const _CalcChip({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: emphasize ? const Color(0xFFE8F6FD) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: emphasize ? const Color(0xFF8BCBE1) : const Color(0xFFD7E0EA),
        ),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
    );
  }
}

class _TransactionList extends StatelessWidget {
  const _TransactionList({required this.controller});

  final TransactionController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.transactions.isEmpty) {
      return const Center(child: Text('Belum ada transaksi.'));
    }
    return ListView.separated(
      itemCount: controller.transactions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = controller.transactions[index];
        return InkWell(
          onTap: () => controller.loadDetail(item.id),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFD7E0EA)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.code,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.paymentMethod} | ${item.status} | ${item.totalAmount}',
                ),
                const SizedBox(height: 4),
                Text('${item.transactionDate} | Queue ${item.queueNumber}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TransactionDetailPanel extends StatelessWidget {
  const _TransactionDetailPanel({required this.controller});

  final TransactionController controller;

  @override
  Widget build(BuildContext context) {
    final detail = controller.selectedDetail.value;
    if (detail == null) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFD7E0EA)),
        ),
        alignment: Alignment.center,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Pilih transaksi untuk melihat detail dan action payment.',
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD7E0EA)),
      ),
      child: ListView(
        children: [
          Text(
            detail.code,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            '${detail.paymentMethod} | ${detail.status} | Total ${detail.totalAmount}',
          ),
          const SizedBox(height: 6),
          Text('Queue ${detail.queueNumber} | ${detail.transactionDate}'),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _CalcChip(label: 'Subtotal', value: detail.subTotal),
              _CalcChip(label: 'Service', value: detail.totalServiceCharge),
              _CalcChip(label: 'Tax', value: detail.totalTax),
              _CalcChip(label: 'Rounding', value: detail.totalRounding),
              _CalcChip(
                label: 'Grand Total',
                value: detail.totalAmount,
                emphasize: true,
              ),
              _CalcChip(label: 'Tendered', value: detail.cashTendered),
              _CalcChip(label: 'Change', value: detail.cashChange),
            ],
          ),
          const SizedBox(height: 16),
          ...detail.items.map(
            (item) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.productName),
              subtitle: Text('Qty ${item.qty} x ${item.price}'),
              trailing: Text(item.totalPrice),
            ),
          ),
          if (detail.notes.isNotEmpty) ...[
            const Divider(height: 24),
            Text(
              'Catatan',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(detail.notes),
          ],
          const Divider(height: 24),
          TextField(
            controller: controller.paymentTrxIdController,
            decoration: const InputDecoration(
              labelText: 'Payment Trx Id',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.paymentReferenceController,
            decoration: const InputDecoration(
              labelText: 'Payment Reference',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.qrContentController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'QR Content',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton(
                onPressed: controller.initiatePayment,
                child: const Text('Initiate Payment'),
              ),
              OutlinedButton(
                onPressed: controller.markTransactionPaid,
                child: const Text('Mark Paid'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0C4C4)),
      ),
      child: Text(message, style: const TextStyle(color: Color(0xFF9C2D2D))),
    );
  }
}
