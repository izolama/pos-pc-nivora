import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class ProductManagementView extends GetView<ProductController> {
  const ProductManagementView({super.key});

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
                  'Produk',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : controller.recalculatePrices,
                  child: const Text('Recalculate'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : controller.loadInitialData,
                  child: const Text('Refresh'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: controller.startCreate,
                  child: const Text('Baru'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (controller.errorMessage.value.isNotEmpty)
              _ProductErrorBox(message: controller.errorMessage.value),
            if (controller.errorMessage.value.isNotEmpty)
              const SizedBox(height: 12),
            _ProductForm(controller: controller),
            const SizedBox(height: 18),
            Expanded(
              child:
                  controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.products.isEmpty
                      ? const Center(
                        child: Text(
                          'Belum ada data produk atau API belum memberi respons.',
                        ),
                      )
                      : ListView.separated(
                        itemCount: controller.products.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = controller.products[index];
                          final categoryText = item.categories
                              .map((category) => category.name)
                              .join(', ');
                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFD7E0EA),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'SKU: ${item.sku} | Qty: ${item.qty} | Harga: ${item.finalPrice.toStringAsFixed(0)}',
                                      ),
                                      const SizedBox(height: 4),
                                      Text(item.description),
                                      const SizedBox(height: 4),
                                      Text(
                                        categoryText.isEmpty
                                            ? 'Tanpa kategori'
                                            : categoryText,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color: const Color(0xFF5C6E80),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                IconButton(
                                  onPressed: () => controller.startEdit(item),
                                  icon: const Icon(Icons.edit_outlined),
                                ),
                                IconButton(
                                  onPressed:
                                      () => controller.deleteProduct(item.id),
                                  icon: const Icon(Icons.delete_outline),
                                ),
                              ],
                            ),
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

class _ProductForm extends StatelessWidget {
  const _ProductForm({required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama produk',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<int>(
                value: controller.selectedCategoryId.value,
                items:
                    controller.categories
                        .map(
                          (category) => DropdownMenuItem<int>(
                            value: category.id,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                onChanged:
                    (value) => controller.selectedCategoryId.value = value,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.priceController,
                decoration: const InputDecoration(
                  labelText: 'Harga',
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
            Expanded(
              child: TextField(
                controller: controller.skuController,
                decoration: const InputDecoration(
                  labelText: 'SKU',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller.upcController,
                decoration: const InputDecoration(
                  labelText: 'UPC',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller.imageThumbUrlController,
                decoration: const InputDecoration(
                  labelText: 'Thumbnail URL',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.descriptionController,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Deskripsi',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Obx(
                () => SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Stock aktif'),
                  value: controller.isStock.value,
                  onChanged: (value) => controller.isStock.value = value,
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Produk aktif'),
                  value: controller.isActive.value,
                  onChanged: (value) => controller.isActive.value = value,
                ),
              ),
            ),
            FilledButton(
              onPressed:
                  controller.isSubmitting.value ? null : controller.submit,
              child: Text(
                controller.isSubmitting.value
                    ? 'Menyimpan...'
                    : controller.isEditing
                    ? 'Update produk'
                    : 'Tambah produk',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProductErrorBox extends StatelessWidget {
  const _ProductErrorBox({required this.message});

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
