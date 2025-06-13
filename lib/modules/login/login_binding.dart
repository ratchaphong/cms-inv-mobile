import 'package:cms_inv_mobile/modules/login/login_view_model.dart';
import 'package:cms_inv_mobile/services/auth_service.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService()); // ✅ Register service
    Get.lazyPut<LoginViewModel>(() => LoginViewModel()); // ✅ Register viewmodel
  }
}
