import 'package:cms_inv_mobile/shared/widgets/app_drawer.dart';
import 'package:cms_inv_mobile/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<DashboardViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(title: "Dashboard", centerTitle: true),
      drawer: const AppDrawer(),
      body: Obx(() {
        if (vm.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final stats = vm.stats.value;
        if (stats == null) {
          return const Center(child: Text('ไม่พบข้อมูล'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatCard("Total Products", stats.totalProducts),
              _buildStatCard("Stock In Today", stats.stockInToday),
              _buildStatCard("Stock Out Today", stats.stockOutToday),
              _buildStatCard("Total Users", stats.totalUsers),
              const SizedBox(height: 24),
              const Text("Available Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...stats.availableProducts.map(
                (p) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(p.name),
                    subtitle: Text("คงเหลือ: ${p.quantity}"),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(String label, int value) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text(value.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
