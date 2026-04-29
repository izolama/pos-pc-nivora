import 'package:get/get.dart';

import '../data/config/app_environment.dart';
import '../data/network/api_client.dart';
import '../data/network/auth_token_store.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/category_repository.dart';
import '../data/repositories/payment_setting_repository.dart';
import '../data/repositories/product_repository.dart';
import '../data/repositories/report_repository.dart';
import '../data/repositories/stock_repository.dart';
import '../data/repositories/transaction_repository.dart';
import '../data/repositories/upload_repository.dart';
import '../data/services/auth_api_service.dart';
import '../data/services/category_api_service.dart';
import '../data/services/payment_setting_api_service.dart';
import '../data/services/pos_sync_service.dart';
import '../data/services/product_api_service.dart';
import '../data/services/report_api_service.dart';
import '../data/services/stock_api_service.dart';
import '../data/services/transaction_api_service.dart';
import '../data/services/upload_api_service.dart';
import '../modules/auth/controllers/auth_controller.dart';
import '../modules/category/controllers/category_controller.dart';
import '../modules/dashboard/controllers/dashboard_controller.dart';
import '../modules/payment/controllers/payment_setting_controller.dart';
import '../modules/product/controllers/product_controller.dart';
import '../modules/report/controllers/report_controller.dart';
import '../modules/stock/controllers/stock_controller.dart';
import '../modules/transaction/controllers/transaction_controller.dart';
import '../modules/upload/controllers/upload_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthTokenStore(), permanent: true);
    Get.put(
      ApiClient(baseUrl: AppEnvironment.posBaseUrl, tokenStore: Get.find()),
      permanent: true,
    );
    Get.put(
      AuthApiService(apiClient: Get.find(), tokenStore: Get.find()),
      permanent: true,
    );
    Get.put(CategoryApiService(apiClient: Get.find()), permanent: true);
    Get.put(ProductApiService(apiClient: Get.find()), permanent: true);
    Get.put(StockApiService(apiClient: Get.find()), permanent: true);
    Get.put(PaymentSettingApiService(apiClient: Get.find()), permanent: true);
    Get.put(ReportApiService(apiClient: Get.find()), permanent: true);
    Get.put(UploadApiService(apiClient: Get.find()), permanent: true);
    Get.put(TransactionApiService(apiClient: Get.find()), permanent: true);
    Get.put(AuthRepository(service: Get.find()), permanent: true);
    Get.put(CategoryRepository(service: Get.find()), permanent: true);
    Get.put(ProductRepository(service: Get.find()), permanent: true);
    Get.put(StockRepository(service: Get.find()), permanent: true);
    Get.put(PaymentSettingRepository(service: Get.find()), permanent: true);
    Get.put(ReportRepository(service: Get.find()), permanent: true);
    Get.put(UploadRepository(service: Get.find()), permanent: true);
    Get.put(TransactionRepository(service: Get.find()), permanent: true);
    Get.put(PosSyncService(), permanent: true);
    Get.put(AuthController(repository: Get.find()), permanent: true);
    Get.put(CategoryController(repository: Get.find()), permanent: true);
    Get.put(
      StockController(
        stockRepository: Get.find(),
        productRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put(PaymentSettingController(repository: Get.find()), permanent: true);
    Get.put(ReportController(repository: Get.find()), permanent: true);
    Get.put(UploadController(repository: Get.find()), permanent: true);
    Get.put(
      ProductController(
        productRepository: Get.find(),
        categoryRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put(
      TransactionController(
        transactionRepository: Get.find(),
        productRepository: Get.find(),
      ),
      permanent: true,
    );
    Get.put(DashboardController(syncService: Get.find()), permanent: true);
  }
}
