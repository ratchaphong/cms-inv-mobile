import 'package:cms_inv_mobile/models/entities/user_profile_model.dart';
import 'package:cms_inv_mobile/services/profile_service.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  final _service = Get.find<ProfileService>();

  var loading = true.obs;
  var profile = Rxn<UserProfileModel>();

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    loading.value = true;
    profile.value = await _service.fetchProfile();
    loading.value = false;
  }

  void goToEdit() {
    Get.toNamed('/edit-profile');
  }
}
