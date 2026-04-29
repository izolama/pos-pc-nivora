import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/app_binding.dart';
import 'routes/app_pages.dart';
import 'theme/app_theme.dart';

class PosPcApp extends StatelessWidget {
  const PosPcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'POS PC Nivora',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: AppTheme.theme,
    );
  }
}
