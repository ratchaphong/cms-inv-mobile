import 'package:cms_inv_mobile/shared/enums/product_status.dart';
import 'package:cms_inv_mobile/shared/widgets/app_drawer.dart';
import 'package:cms_inv_mobile/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'products_view_model.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ProductsViewModel>();

    return Scaffold(
      appBar: const CustomAppBar(title: "รายการสินค้า"),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddProductDialog(context, vm);
        },
        label: const Text("เพิ่มสินค้า"),
        icon: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (vm.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.products.isEmpty) {
          return const Center(child: Text("ไม่มีรายการสินค้า"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: vm.products.length,
          itemBuilder: (context, index) {
            final product = vm.products[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text(product.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                subtitle: Text("สต็อกคงเหลือ: ${product.currentStock}"),
                trailing: Chip(
                  label: Text(product.status.label),
                  backgroundColor: Colors.blue.shade50,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showAddProductDialog(BuildContext context, ProductsViewModel vm) {
    final nameController = TextEditingController();
    final stockController = TextEditingController();
    final categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("เพิ่มสินค้าใหม่"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "ชื่อสินค้า"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "หมวดหมู่"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: "จำนวนเริ่มต้น"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("ยกเลิก"),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final category = categoryController.text.trim();
              final stock = int.tryParse(stockController.text.trim()) ?? 0;

              if (name.isNotEmpty && category.isNotEmpty) {
                vm.addProduct(name, category, stock);
                Get.back();
              } else {
                Get.snackbar("กรอกไม่ครบ", "โปรดกรอกข้อมูลให้ครบถ้วน");
              }
            },
            child: const Text("บันทึก"),
          ),
        ],
      ),
    );
  }
}
