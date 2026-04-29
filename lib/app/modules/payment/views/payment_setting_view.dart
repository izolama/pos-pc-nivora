import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_setting_controller.dart';

class PaymentSettingView extends GetView<PaymentSettingController> {
  const PaymentSettingView({super.key});

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
              'Payment Setting',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            if (controller.errorMessage.value.isNotEmpty)
              _ErrorBox(message: controller.errorMessage.value),
            if (controller.errorMessage.value.isNotEmpty)
              const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: controller.taxNameController,
                    decoration: const InputDecoration(
                      labelText: 'Tax name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: controller.taxPercentageController,
                    decoration: const InputDecoration(
                      labelText: 'Tax percentage',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: controller.roundingTargetController,
                    decoration: const InputDecoration(
                      labelText: 'Rounding target',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: DropdownButtonFormField<String>(
                    value: controller.roundingType.value,
                    items: const [
                      DropdownMenuItem(value: 'NONE', child: Text('NONE')),
                      DropdownMenuItem(value: 'UP', child: Text('UP')),
                      DropdownMenuItem(value: 'DOWN', child: Text('DOWN')),
                    ],
                    onChanged:
                        (value) =>
                            controller.roundingType.value = value ?? 'NONE',
                    decoration: const InputDecoration(
                      labelText: 'Rounding type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: controller.serviceChargePercentageController,
                    decoration: const InputDecoration(
                      labelText: 'Service charge %',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: controller.serviceChargeAmountController,
                    decoration: const InputDecoration(
                      labelText: 'Service charge amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(
              () => Wrap(
                spacing: 18,
                runSpacing: 8,
                children: [
                  _SwitchInline(
                    label: 'Price include tax',
                    value: controller.isPriceIncludeTax.value,
                    onChanged:
                        (value) => controller.isPriceIncludeTax.value = value,
                  ),
                  _SwitchInline(
                    label: 'Rounding',
                    value: controller.isRounding.value,
                    onChanged: (value) => controller.isRounding.value = value,
                  ),
                  _SwitchInline(
                    label: 'Service charge',
                    value: controller.isServiceCharge.value,
                    onChanged:
                        (value) => controller.isServiceCharge.value = value,
                  ),
                  _SwitchInline(
                    label: 'Tax active',
                    value: controller.isTax.value,
                    onChanged: (value) => controller.isTax.value = value,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: controller.save,
                child: const Text('Simpan Setting'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchInline extends StatelessWidget {
  const _SwitchInline({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Text(label), Switch(value: value, onChanged: onChanged)],
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
