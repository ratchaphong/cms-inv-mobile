// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/routes/app_pages.dart';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("🔥 onInit() called from SplashViewModel");
    Future.delayed(const Duration(seconds: 2), checkAuth);
  }

  void checkAuth() {
    final box = GetStorage();
    final token = box.read('token');
    final loginTime = box.read('loginTime');
    final now = DateTime.now().millisecondsSinceEpoch;

    print("🟡 Token: $token");
    print("🕒 Login Time: $loginTime");
    print("🕒 Current Time: $now");

    if (token != null && loginTime != null) {
      final remainingMs = 3600000 - (now - loginTime);
      final remainingMin = (remainingMs / 1000 / 60).floor();
      final remainingSec = ((remainingMs / 1000) % 60).floor();
      print("⏳ Remaining Time: ${remainingMin}m ${remainingSec}s");

      if (now - loginTime <= 3600000) {
        print("✅ Token is still valid, redirecting to dashboard");
        Get.offAllNamed(AppRoutes.dashboard);
        return;
      } else {
        print("⛔ Token expired, redirecting to login");
      }
    } else {
      print("🔴 Token or loginTime missing, redirecting to login");
    }

    Get.offAllNamed(AppRoutes.login);
  }
}
