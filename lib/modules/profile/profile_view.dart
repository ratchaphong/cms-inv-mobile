import 'package:cms_inv_mobile/models/entities/user_profile_model.dart';
import 'package:cms_inv_mobile/shared/widgets/app_drawer.dart';
import 'package:cms_inv_mobile/shared/widgets/avatar_image.dart';
import 'package:cms_inv_mobile/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ProfileViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'ข้อมูลส่วนตัว'),
      drawer: const AppDrawer(),
      body: Obx(() {
        if (vm.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final UserProfileModel? p = vm.profile.value;
        if (p == null) {
          return Center(
              child: Text('ไม่พบข้อมูล', style: theme.textTheme.bodyMedium));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('👋 สวัสดีคุณ ${p.name}',
                  style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              AvatarImage(
                source: p.avatarUrl,
                radius: 48.0,
                fallbackAsset: 'assets/images/bstore.png',
              ),
              const SizedBox(height: 24),
              _buildInfoRow('ชื่อ - สกุล', p.name),
              _buildInfoRow('อีเมล', p.email),
              _buildInfoRow('เบอร์โทร', p.phoneNumber),
              _buildInfoRow('ที่อยู่', p.address ?? '-'),
              _buildInfoRow('สิทธิ์', p.role),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: vm.goToEdit,
                icon: const Icon(Icons.edit),
                label: const Text('แก้ไขข้อมูลส่วนตัว'),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
