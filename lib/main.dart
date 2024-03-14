import 'package:st_test_app/src/services/init_services.dart';
import 'package:st_test_app/src/utils/translations.dart';
import 'package:st_test_app/src/pages/home_screen.dart';
import 'package:st_test_app/src/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
  InitServices.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'title'.tr,
      theme: AppTheme().custom,
      home: const HomeScreen(),
      translations: Language(),
      locale: const Locale('es', 'MX'),
      debugShowCheckedModeBanner: false,
    );
  }
}
