import 'package:cms_inv_mobile/app/routes/app_pages.dart';
import 'package:cms_inv_mobile/models/entities/user_profile_model.dart';
import 'package:cms_inv_mobile/models/requests/edit_profile_request.dart';
import 'package:cms_inv_mobile/services/profile_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'dart:convert';

class EditProfileViewModel extends GetxController {
  final _service = Get.find<ProfileService>();
  final ImagePicker _picker = ImagePicker();

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

  /// เปิด gallery ให้เลือกภาพ แปลงเป็น base64 Data URI พร้อมตรวจขนาดและคุณภาพ
  Future<void> pickImage() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (file == null) return;

      final bytes = await file.readAsBytes();
      const maxBytes = 5 * 1024 * 1024; // 5MB
      if (bytes.length > maxBytes) {
        Get.snackbar('ไฟล์ใหญ่เกินไป', 'ขนาดรูปต้องไม่เกิน 5MB');
        return;
      }

      final mimeType = lookupMimeType(file.path) ?? 'image/jpeg';
      avatarUrl.value = 'data:$mimeType;base64,${base64Encode(bytes)}';
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาด', 'ไม่สามารถเลือกภาพได้');
    }
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
