import 'package:cms_inv_mobile/app/routes/app_pages.dart';
import 'package:cms_inv_mobile/models/entities/user_model.dart';
import 'package:cms_inv_mobile/models/requests/login_request.dart';
import 'package:cms_inv_mobile/models/requests/register_request.dart';
import 'package:cms_inv_mobile/services/auth_service.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final name = ''.obs; // สำหรับโหมดลงทะเบียน
  final isLoading = false.obs;
  final isRegisterMode = false.obs;

  final authService = Get.find<AuthService>();

  UserModel? currentUser;
  String? token;

  void toggleMode() {
    isRegisterMode.value = !isRegisterMode.value;
  }

  void loginOrRegister() async {
    isLoading.value = true;

    if (isRegisterMode.value) {
      // ✅ ลงทะเบียน
      final registerReq = RegisterRequest(
        name: name.value,
        email: email.value,
        password: password.value,
      );

      final success = await authService.register(registerReq);
      if (success) {
        Get.snackbar("สำเร็จ", "ลงทะเบียนเรียบร้อยแล้ว 🎉");
        toggleMode(); // ✅ กลับเป็นโหมด login
      } else {
        Get.snackbar("ผิดพลาด", "ไม่สามารถลงทะเบียนได้");
      }
    } else {
      // ✅ เข้าสู่ระบบ
      final loginReq = LoginRequest(
        email: email.value,
        password: password.value,
      );

      final result = await authService.login(loginReq);
      if (result != null) {
        token = result.token;
        Get.snackbar("สำเร็จ", "เข้าสู่ระบบแล้ว");
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.snackbar("ผิดพลาด", "อีเมลหรือรหัสผ่านไม่ถูกต้อง");
      }
    }

    isLoading.value = false;
  }
}
