import 'package:get/get.dart';

import '../../../data/models/menu_models.dart';
import '../../../data/services/pos_sync_service.dart';
import '../../../routes/app_pages.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../category/controllers/category_controller.dart';
import '../../payment/controllers/payment_setting_controller.dart';
import '../../product/controllers/product_controller.dart';
import '../../report/controllers/report_controller.dart';
import '../../stock/controllers/stock_controller.dart';
import '../../transaction/controllers/transaction_controller.dart';
import '../../upload/controllers/upload_controller.dart';

class DashboardController extends GetxController {
  DashboardController({required this.syncService});

  final PosSyncService syncService;
  final AuthController authController = Get.find();
  final CategoryController categoryController = Get.find();
  final StockController stockController = Get.find();
  final PaymentSettingController paymentSettingController = Get.find();
  final ReportController reportController = Get.find();
  final UploadController uploadController = Get.find();
  final ProductController productController = Get.find();
  final TransactionController transactionController = Get.find();

  late final List<PosMenuCategory> categories;
  late final RxString selectedCategoryKey;
  late final RxString selectedMenuKey;

  Map<String, dynamic> get deviceStatus => syncService.getDesktopStatus();

  PosMenuCategory get selectedCategory => categories.firstWhere(
    (category) => category.key == selectedCategoryKey.value,
  );

  PosMenuItem get selectedMenu => selectedCategory.items.firstWhere(
    (item) => item.key == selectedMenuKey.value,
    orElse: () => selectedCategory.items.first,
  );

  @override
  void onInit() {
    super.onInit();
    categories = syncService.categories;
    selectedCategoryKey = categories.first.key.obs;
    selectedMenuKey = categories.first.items.first.key.obs;
  }

  @override
  void onReady() {
    super.onReady();
    if (!authController.isLoggedIn) {
      Get.offAllNamed(AppPages.login);
      return;
    }
    categoryController.loadCategories();
    productController.loadInitialData();
    stockController.loadProducts();
    paymentSettingController.load();
    reportController.load();
    transactionController.loadInitialData();
  }

  void selectCategory(String key) {
    final category = categories.firstWhere((item) => item.key == key);
    selectedCategoryKey.value = category.key;
    selectedMenuKey.value = category.items.first.key;
  }

  void selectMenu(String key) {
    selectedMenuKey.value = key;
  }

  Future<void> logout() async {
    await authController.logout();
  }
}
