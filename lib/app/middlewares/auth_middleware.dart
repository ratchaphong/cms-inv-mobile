import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final token = GetStorage().read('token');
    final loginTime = GetStorage().read('loginTime');
    final now = DateTime.now().millisecondsSinceEpoch;

    const sessionDuration = 60 * 60 * 1000; // 1 ชั่วโมง

    final isLoggedIn = token != null &&
        loginTime != null &&
        now - loginTime <= sessionDuration;

    if (!isLoggedIn) {
      return const RouteSettings(name: AppRoutes.login);
    }

    return null; // ✅ ผ่าน
  }
}
