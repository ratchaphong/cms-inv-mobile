import 'package:cms_inv_mobile/app/routes/app_pages.dart';
import 'package:cms_inv_mobile/models/entities/user_profile_model.dart';
import 'package:cms_inv_mobile/models/requests/edit_profile_request.dart';
import 'package:cms_inv_mobile/services/profile_service.dart';
import 'package:get/get.dart';

class EditProfileViewModel extends GetxController {
  final _service = Get.find<ProfileService>();

  var loading = true.obs;
  var profile = Rxn<UserProfileModel>();

  // form fields
  final name = ''.obs;
  final email = ''.obs;
  final phone = ''.obs;
  final address = ''.obs;
  final avatarUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    loading.value = true;
    final p = await _service.fetchProfile();
    profile.value = p;
    if (p != null) {
      name.value = p.name;
      email.value = p.email;
      phone.value = p.phoneNumber;
      address.value = p.address ?? '';
      avatarUrl.value = p.avatarUrl ?? '';
    }
    loading.value = false;
  }

  Future<void> submit() async {
    if (name.value.isEmpty || email.value.isEmpty) {
      Get.snackbar('กรุณากรอกข้อมูล', 'ชื่อและอีเมลห้ามว่าง');
      return;
    }
    loading.value = true;

    final req = EditProfileRequest(
      userId: profile.value!.id,
      name: name.value,
      email: email.value,
      phoneNumber: phone.value,
      address: address.value.isEmpty ? null : address.value,
      avatarUrl: avatarUrl.value.isEmpty ? null : avatarUrl.value,
    );

    final updated = await _service.updateProfile(req);
    loading.value = false;

    if (updated != null) {
      profile.value = updated;
      Get.snackbar('สำเร็จ', 'แก้ไขข้อมูลสำเร็จ');
      // แทน Get.back() ให้ไปหน้า /profile ใหม่
      Get.offAllNamed(AppRoutes.profile);
    } else {
      Get.snackbar('ผิดพลาด', 'ไม่สามารถอัปเดตได้');
    }
  }
}
