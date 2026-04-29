import 'package:get/get.dart';

import '../data/services/pos_sync_service.dart';
import '../modules/dashboard/controllers/dashboard_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PosSyncService(), permanent: true);
    Get.put(DashboardController(syncService: Get.find()), permanent: true);
  }
}
