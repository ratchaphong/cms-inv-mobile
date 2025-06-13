// lib/shared/widgets/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/routes/app_pages.dart';
import 'bstore_logo.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerHeaderHeight = MediaQuery.of(context).size.height / 3;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: SizedBox(
              height: drawerHeaderHeight,
              child: const Center(
                child: BStoreLogo(color: Colors.white),
              ),
            ),
          ),
          _buildDrawerItem("Dashboard", Icons.dashboard, AppRoutes.dashboard),
          _buildDrawerItem("Profile", Icons.person, AppRoutes.profile),
          _buildDrawerItem("Products", Icons.inventory_2, AppRoutes.products),
          _buildDrawerItem("Stock", Icons.swap_vert, AppRoutes.stocks),
          _buildDrawerItem("Report", Icons.bar_chart, AppRoutes.report),
          // เพิ่มเมนูอื่น ๆ ได้ตามต้องการ
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("ออกจากระบบ"),
            onTap: () {
              GetStorage().erase(); // ล้าง token & session
              Get.offAllNamed(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // ปิด drawer ก่อน แล้ว navigate
        Get.back();
        // Get.toNamed(route);
        Get.offNamed(route); // replace หน้าเดิมด้วย route ใหม่
      },
    );
  }
}
