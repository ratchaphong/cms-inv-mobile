import 'package:cms_inv_mobile/shared/widgets/app_drawer.dart';
import 'package:cms_inv_mobile/shared/widgets/avatar_image.dart';
import 'package:cms_inv_mobile/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<EditProfileViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'แก้ไขข้อมูลส่วนตัว'),
      drawer: const AppDrawer(),
      body: Obx(() {
        if (vm.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              GestureDetector(
                onTap: vm.pickImage, // เรียก pickImage ใน ViewModel
                child: AvatarImage(
                  source: vm.avatarUrl.value,
                  radius: 48.0,
                  fallbackAsset: 'assets/images/bstore.png',
                ),
              ),
              const SizedBox(height: 12),
              Text('คลิกที่รูปเพื่อเปลี่ยนภาพ',
                  style: theme.textTheme.bodySmall),
              const SizedBox(height: 24),

              // Name
              TextFormField(
                initialValue: vm.name.value,
                decoration: const InputDecoration(labelText: 'ชื่อ - นามสกุล'),
                onChanged: (v) => vm.name.value = v,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                initialValue: vm.email.value,
                decoration: const InputDecoration(labelText: 'อีเมล'),
                onChanged: (v) => vm.email.value = v,
              ),
              const SizedBox(height: 16),

              // Phone
              TextFormField(
                initialValue: vm.phone.value,
                decoration: const InputDecoration(labelText: 'เบอร์โทรศัพท์'),
                onChanged: (v) => vm.phone.value = v,
              ),
              const SizedBox(height: 16),

              // Address
              TextFormField(
                initialValue: vm.address.value,
                decoration: const InputDecoration(labelText: 'ที่อยู่'),
                onChanged: (v) => vm.address.value = v,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: vm.submit,
                  child: const Text('บันทึก'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
