import 'package:get/get.dart';

import '../modules/auth/views/login_view.dart';
import '../modules/dashboard/views/dashboard_view.dart';

class AppPages {
  static const initial = '/login';
  static const login = '/login';
  static const dashboard = '/dashboard';

  static final routes = [
    GetPage<void>(name: login, page: () => const LoginView()),
    GetPage<void>(name: dashboard, page: () => const DashboardView()),
  ];
}
