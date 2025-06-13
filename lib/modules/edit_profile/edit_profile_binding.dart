import 'package:cms_inv_mobile/modules/edit_profile/edit_profile_view_model.dart';
import 'package:cms_inv_mobile/services/profile_service.dart';
import 'package:get/get.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileService());
    Get.lazyPut(() => EditProfileViewModel());
  }
}
