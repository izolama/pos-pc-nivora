import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/menu_models.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../category/views/category_management_view.dart';
import '../../payment/views/payment_setting_view.dart';
import '../../product/views/product_management_view.dart';
import '../../report/views/report_summary_view.dart';
import '../../stock/views/stock_management_view.dart';
import '../../transaction/views/transaction_management_view.dart';
import '../../upload/views/upload_management_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F2F4),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, viewportConstraints) {
            final minHeight =
                viewportConstraints.maxHeight > 0
                    ? viewportConstraints.maxHeight - 48
                    : 720.0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: minHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _HeaderCard(controller: controller),
                        const SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final compact = constraints.maxWidth < 920;
                            final panelHeight = compact ? 860.0 : 560.0;

                            if (compact) {
                              return SizedBox(
                                height: panelHeight,
                                child: Column(
                                  children: [
                                    _MenuPanel(
                                      controller: controller,
                                      compact: true,
                                    ),
                                    const SizedBox(height: 16),
                                    Expanded(
                                      child: _ContentPanel(
                                        controller: controller,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return SizedBox(
                              height: panelHeight,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    width: 340,
                                    child: _MenuPanel(
                                      controller: controller,
                                      compact: false,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _ContentPanel(
                                      controller: controller,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    final status = controller.deviceStatus;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2C76C7), Color(0xFF5BA2F2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.point_of_sale,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DESAIN TABEL MASTER / ADMIN',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'POS desktop sederhana, siap dikembangkan untuk sinkronisasi ke tablet.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.end,
            children: [
              _StatusBadge(
                label: status['device'] as String,
                tone: _BadgeTone.light,
              ),
              _StatusBadge(
                label: status['shift'] as String,
                tone: _BadgeTone.light,
              ),
              TextButton(
                onPressed: controller.logout,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.16),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuPanel extends StatelessWidget {
  const _MenuPanel({required this.controller, required this.compact});

  final DashboardController controller;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F1FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.storefront, color: Color(0xFF2267B1)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mr.Braid',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'POS PC / Admin Console',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF5F6C7B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Obx(
                  () => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                        controller.categories.map((category) {
                          final selected =
                              controller.selectedCategoryKey.value ==
                              category.key;
                          return _CategoryChip(
                            label: category.label,
                            selected: selected,
                            onTap:
                                () => controller.selectCategory(category.key),
                          );
                        }).toList(),
                  ),
                ),
                const SizedBox(height: 18),
                Obx(
                  () => Column(
                    children:
                        controller.selectedCategory.items.map((item) {
                          final selected =
                              controller.selectedMenuKey.value == item.key;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _MenuButton(
                              item: item,
                              selected: selected,
                              onTap: () => controller.selectMenu(item.key),
                            ),
                          );
                        }).toList(),
                  ),
                ),
                SizedBox(height: compact ? 12 : 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFD7E0EA)),
                  ),
                  child: const Text(
                    'Arsitektur sudah dipisah agar nanti modul sinkronisasi POS tablet bisa masuk tanpa ubah UI utama.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentPanel extends StatelessWidget {
  const _ContentPanel({required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.selectedMenu;
      final authController = Get.find<AuthController>();
      return Container(
        padding: const EdgeInsets.all(22),
        decoration: _panelDecoration(),
        child: ListView(
          children: [
            Text(
              item.label,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1D2A39),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF627080)),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                _InfoStat(
                  title: 'Status Login',
                  value: authController.isLoggedIn ? 'Aktif' : 'Belum',
                ),
                const _InfoStat(
                  title: 'Modul Master',
                  value: 'Kategori + Produk',
                ),
                const _InfoStat(title: 'Shift Hari Ini', value: '3'),
              ],
            ),
            const SizedBox(height: 22),
            if (item.key == 'user')
              _SessionPanel(authController: authController),
            if (item.key == 'item') const _MasterItemPanel(),
            if (item.key == 'stock') const _StockPanel(),
            if (item.key == 'payment-setting') const _PaymentSettingPanel(),
            if (item.key == 'upload') const _UploadPanel(),
            if (item.key == 'shift') const _TransactionPanel(),
            if (item.key == 'shift-report' ||
                item.key == 'daily-report' ||
                item.key == 'sales-report' ||
                item.key == 'stats')
              const _ReportPanel(),
            if (item.key != 'user' &&
                item.key != 'item' &&
                item.key != 'stock' &&
                item.key != 'payment-setting' &&
                item.key != 'upload' &&
                item.key != 'shift' &&
                item.key != 'shift-report' &&
                item.key != 'daily-report' &&
                item.key != 'sales-report' &&
                item.key != 'stats')
              const _ComingSoonPanel(),
          ],
        ),
      );
    });
  }
}

class _SessionPanel extends StatelessWidget {
  const _SessionPanel({required this.authController});

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFD),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD5DFEA)),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status sesi API',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Text(
              authController.isLoggedIn
                  ? 'Token login aktif dan siap dipakai untuk request category dan product.'
                  : 'Belum ada token aktif. Kembali ke login untuk memulai sesi.',
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFD8E3ED)),
              ),
              child: Text(
                authController.isLoggedIn
                    ? authController.maskedToken
                    : 'Token belum tersedia',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MasterItemPanel extends StatelessWidget {
  const _MasterItemPanel();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 4),
        SizedBox(height: 420, child: CategoryManagementView()),
        SizedBox(height: 18),
        SizedBox(height: 560, child: ProductManagementView()),
      ],
    );
  }
}

class _TransactionPanel extends StatelessWidget {
  const _TransactionPanel();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 860, child: TransactionManagementView());
  }
}

class _StockPanel extends StatelessWidget {
  const _StockPanel();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 560, child: StockManagementView());
  }
}

class _PaymentSettingPanel extends StatelessWidget {
  const _PaymentSettingPanel();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 420, child: PaymentSettingView());
  }
}

class _UploadPanel extends StatelessWidget {
  const _UploadPanel();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 320, child: UploadManagementView());
  }
}

class _ReportPanel extends StatelessWidget {
  const _ReportPanel();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 620, child: ReportSummaryView());
  }
}

class _ComingSoonPanel extends StatelessWidget {
  const _ComingSoonPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFD),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD5DFEA)),
      ),
      child: const Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          SizedBox(
            width: 280,
            child: _ActionCard(
              icon: Icons.receipt_long_outlined,
              title: 'Modul Transaksi',
              description:
                  'Tahap berikutnya menghubungkan cart, create transaction, dan update payment.',
            ),
          ),
          SizedBox(
            width: 280,
            child: _ActionCard(
              icon: Icons.sync_alt,
              title: 'Bridge Tablet',
              description:
                  'Disiapkan sebagai service layer untuk sinkronisasi LAN/API.',
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          gradient:
              selected
                  ? const LinearGradient(
                    colors: [Color(0xFF1E8BCB), Color(0xFF4FB8D4)],
                  )
                  : null,
          color: selected ? null : const Color(0xFFF4F7FA),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Colors.transparent : const Color(0xFFD2DDE9),
          ),
          boxShadow:
              selected
                  ? const [
                    BoxShadow(
                      color: Color(0x220F75AE),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ]
                  : null,
        ),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: selected ? Colors.white : const Color(0xFF3E4B5B),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final PosMenuItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEAF6FD) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:
                  selected ? const Color(0xFF56B8D9) : const Color(0xFFD9E2EB),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  item.label,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color:
                    selected
                        ? const Color(0xFF1393BB)
                        : const Color(0xFF95A3B3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoStat extends StatelessWidget {
  const _InfoStat({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD5DFEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF728194)),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8E3ED)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F6FD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFF177DA8)),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF667689)),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label, required this.tone});

  final String label;
  final _BadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = switch (tone) {
      _BadgeTone.light => Colors.white.withValues(alpha: 0.16),
    };
    final foregroundColor = switch (tone) {
      _BadgeTone.light => Colors.white,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

enum _BadgeTone { light }

BoxDecoration _panelDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(22),
    border: Border.all(color: const Color(0xFFD7E1EB)),
    boxShadow: const [
      BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, 8)),
    ],
  );
}
