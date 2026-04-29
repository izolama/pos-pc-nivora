import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/upload_controller.dart';

class UploadManagementView extends GetView<UploadController> {
  const UploadManagementView({super.key});

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
        child: ListView(
          children: [
            Text(
              'Upload Media',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            if (controller.errorMessage.value.isNotEmpty)
              _ErrorBox(message: controller.errorMessage.value),
            if (controller.errorMessage.value.isNotEmpty)
              const SizedBox(height: 12),
            FilledButton(
              onPressed:
                  controller.isLoading.value ? null : controller.pickAndUpload,
              child: Text(
                controller.isLoading.value
                    ? 'Uploading...'
                    : 'Pilih dan Upload Image',
              ),
            ),
            const SizedBox(height: 16),
            if (controller.selectedFileName.value.isNotEmpty)
              Text('File: ${controller.selectedFileName.value}'),
            if (controller.uploaded.value != null) ...[
              const SizedBox(height: 12),
              SelectableText('Full URL: ${controller.uploaded.value!.urlFull}'),
              const SizedBox(height: 8),
              SelectableText(
                'Thumb URL: ${controller.uploaded.value!.urlThumb}',
              ),
            ],
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
