import '../models/menu_models.dart';

class PosSyncService {
  final List<PosMenuCategory> categories = const [
    PosMenuCategory(
      key: 'master',
      label: 'Master',
      items: [
        PosMenuItem(
          key: 'user',
          label: 'User',
          description: 'Kelola akun operator, admin, dan hak akses POS PC.',
        ),
        PosMenuItem(
          key: 'item',
          label: 'Master Item',
          description: 'Kelola data produk, kategori, dan harga jual.',
        ),
      ],
    ),
    PosMenuCategory(
      key: 'transaksi',
      label: 'Transaksi',
      items: [
        PosMenuItem(
          key: 'shift',
          label: 'Transaksi User per Shift',
          description: 'Pantau transaksi aktif berdasarkan shift kasir.',
        ),
      ],
    ),
    PosMenuCategory(
      key: 'laporan',
      label: 'Laporan',
      items: [
        PosMenuItem(
          key: 'shift-report',
          label: 'Laporan Penjualan per Shift',
          description: 'Rekap omzet dan jumlah transaksi tiap shift.',
        ),
        PosMenuItem(
          key: 'daily-report',
          label: 'Laporan Penjualan per Hari',
          description: 'Ringkasan performa penjualan harian.',
        ),
        PosMenuItem(
          key: 'sales-report',
          label: 'Laporan Penjualan',
          description: 'Laporan umum untuk audit dan monitoring cabang.',
        ),
        PosMenuItem(
          key: 'stats',
          label: 'Statistik Penjualan',
          description: 'Indikator item terlaris, jam ramai, dan tren omzet.',
        ),
      ],
    ),
  ];

  Map<String, dynamic> getDesktopStatus() {
    return {
      'device': 'POS PC',
      'connection': 'Standalone',
      'tabletReady': false,
      'shift': 'Shift Pagi',
      'cashier': 'Admin',
    };
  }
}
