import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ ต้องเรียกก่อนใช้ async ใน main
  await GetStorage.init(); // ✅ สำคัญมาก ต้องรอให้ Storage พร้อม

  runApp(const BStoreApp());
}

class BStoreApp extends StatelessWidget {
  const BStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BStore Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
