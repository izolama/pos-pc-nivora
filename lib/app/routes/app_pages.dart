import 'package:get/get.dart';

import '../modules/dashboard/views/dashboard_view.dart';

class AppPages {
  static const initial = '/';

  static final routes = [
    GetPage<void>(name: initial, page: () => const DashboardView()),
  ];
}
