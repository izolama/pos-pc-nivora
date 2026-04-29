import 'package:get/get.dart';

import '../../../data/models/menu_models.dart';
import '../../../data/services/pos_sync_service.dart';

class DashboardController extends GetxController {
  DashboardController({required this.syncService});

  final PosSyncService syncService;

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

  void selectCategory(String key) {
    final category = categories.firstWhere((item) => item.key == key);
    selectedCategoryKey.value = category.key;
    selectedMenuKey.value = category.items.first.key;
  }

  void selectMenu(String key) {
    selectedMenuKey.value = key;
  }
}
