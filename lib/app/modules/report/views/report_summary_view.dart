import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/report_controller.dart';

class ReportSummaryView extends GetView<ReportController> {
  const ReportSummaryView({super.key});

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
        child:
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.report.value == null
                ? Center(
                  child: Text(
                    controller.errorMessage.value.isEmpty
                        ? 'Report belum dimuat.'
                        : controller.errorMessage.value,
                  ),
                )
                : ListView(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Summary Report',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const Spacer(),
                        OutlinedButton(
                          onPressed: controller.load,
                          child: const Text('Refresh'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Produk Terlaris',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...controller.report.value!.productList.map(
                      (item) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.productName),
                        trailing: Text('${item.totalSaleItems} item'),
                      ),
                    ),
                    const Divider(height: 24),
                    Text(
                      'Pembayaran Internal',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ...controller.report.value!.paymentListInternal.map(
                      (item) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.paymentName),
                        subtitle: Text('${item.totalTransactions} transaksi'),
                        trailing: Text(
                          item.totalAmountTransactions.toStringAsFixed(0),
                        ),
                      ),
                    ),
                    const Divider(height: 24),
                    Text(
                      'Pembayaran External',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ...controller.report.value!.paymentListExternal.map(
                      (item) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(item.paymentName),
                        subtitle: Text('${item.totalTransactions} transaksi'),
                        trailing: Text(
                          item.totalAmountTransactions.toStringAsFixed(0),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
