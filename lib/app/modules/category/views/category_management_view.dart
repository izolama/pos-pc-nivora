import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryManagementView extends GetView<CategoryController> {
  const CategoryManagementView({super.key});

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
                  'Kategori',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : controller.loadCategories,
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
              _ErrorBox(message: controller.errorMessage.value),
            if (controller.errorMessage.value.isNotEmpty)
              const SizedBox(height: 12),
            _CategoryForm(controller: controller),
            const SizedBox(height: 18),
            Expanded(
              child:
                  controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.categories.isEmpty
                      ? const Center(
                        child: Text(
                          'Belum ada data kategori atau data belum bisa diambil dari API.',
                        ),
                      )
                      : ListView.separated(
                        itemCount: controller.categories.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = controller.categories[index];
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
                                      Text(item.description),
                                      if (item.imageUrl.isNotEmpty) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          item.imageUrl,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall?.copyWith(
                                            color: const Color(0xFF5C6E80),
                                          ),
                                        ),
                                      ],
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
                                      () => controller.deleteCategory(item.id),
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

class _CategoryForm extends StatelessWidget {
  const _CategoryForm({required this.controller});

  final CategoryController controller;

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
                  labelText: 'Nama kategori',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller.imageController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
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
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton(
            onPressed: controller.isSubmitting.value ? null : controller.submit,
            child: Text(
              controller.isSubmitting.value
                  ? 'Menyimpan...'
                  : controller.isEditing
                  ? 'Update kategori'
                  : 'Tambah kategori',
            ),
          ),
        ),
      ],
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
