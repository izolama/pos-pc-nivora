import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/stock_controller.dart';

class StockManagementView extends GetView<StockController> {
  const StockManagementView({super.key});

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
            Text(
              'Stock',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            if (controller.errorMessage.value.isNotEmpty)
              _ErrorBox(message: controller.errorMessage.value),
            if (controller.errorMessage.value.isNotEmpty)
              const SizedBox(height: 12),
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
                    onChanged: (value) {
                      controller.selectedProductId.value = value;
                      controller.loadMovements();
                    },
                    decoration: const InputDecoration(
                      labelText: 'Produk',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: controller.updateType.value,
                    items: const [
                      DropdownMenuItem(value: 'ADD', child: Text('ADD')),
                      DropdownMenuItem(
                        value: 'SUBTRACT',
                        child: Text('SUBTRACT'),
                      ),
                    ],
                    onChanged:
                        (value) => controller.updateType.value = value ?? 'ADD',
                    decoration: const InputDecoration(
                      labelText: 'Update type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: controller.qtyController,
                    decoration: const InputDecoration(
                      labelText: 'Qty',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: controller.updateStock,
                  child: const Text('Update'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child:
                  controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                        itemCount: controller.movements.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = controller.movements[index];
                          return ListTile(
                            tileColor: const Color(0xFFF8FAFC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Color(0xFFD7E0EA)),
                            ),
                            title: Text('${item.movementType} ${item.qty}'),
                            subtitle: Text(item.movementReason),
                            trailing: Text(item.localDateTime),
                          );
                        },
                      ),
            ),
          ],
        ),
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
