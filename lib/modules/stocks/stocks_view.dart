import 'package:cms_inv_mobile/shared/enums/stock_action.dart';
import 'package:cms_inv_mobile/shared/widgets/app_drawer.dart';
import 'package:cms_inv_mobile/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'stocks_view_model.dart';

class StocksView extends StatelessWidget {
  const StocksView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<StocksViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'จัดการสต็อกสินค้า'),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddStockDialog(context, vm),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (vm.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.stockItems.isEmpty) {
          return Center(
            child: Text(
              'ไม่มีการเคลื่อนไหวสต็อก',
              style: theme.textTheme.bodyMedium,
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: vm.stockItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (ctx, i) {
            final item = vm.stockItems[i];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Left: product info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('dd/MM/yyyy HH:mm')
                                .format(item.createdAt),
                            style: theme.textTheme.bodySmall,
                          ),
                          if (item.note != null && item.note!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                'หมายเหตุ: ${item.note!}',
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Right: quantity + badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: item.type == StockAction.incoming
                                ? Colors.green.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.type.label,
                            style: TextStyle(
                              fontSize: 12,
                              color: item.type == StockAction.incoming
                                  ? Colors.green.shade800
                                  : Colors.red.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void _showAddStockDialog(BuildContext context, StocksViewModel vm) {
    final productController = TextEditingController();
    final qtyController = TextEditingController();
    final noteController = TextEditingController();
    StockAction? selectedAction;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("เพิ่มการเคลื่อนไหวสินค้า"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // เลือกสินค้า
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "เลือกสินค้า"),
              items: vm.products
                  .map(
                    (p) => DropdownMenuItem(
                      value: p.id.toString(),
                      child: Text(p.name),
                    ),
                  )
                  .toList(),
              onChanged: (v) => productController.text = v ?? '',
            ),
            const SizedBox(height: 16),

            // เลือกประเภท
            DropdownButtonFormField<StockAction>(
              decoration: const InputDecoration(labelText: "ประเภท"),
              items: StockAction.values
                  .map((a) => DropdownMenuItem(value: a, child: Text(a.label)))
                  .toList(),
              onChanged: (v) => selectedAction = v,
            ),
            const SizedBox(height: 16),

            // จำนวน
            TextField(
              controller: qtyController,
              decoration: const InputDecoration(labelText: "จำนวน"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // หมายเหตุ
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: "หมายเหตุ (ถ้ามี)"),
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
              final String raw = productController.text.trim();
              final int? productId = int.tryParse(raw);
              final quantity = int.tryParse(qtyController.text.trim()) ?? 0;
              final note = noteController.text.trim().isEmpty
                  ? null
                  : noteController.text.trim();

              if (productId != null && selectedAction != null) {
                vm.addStock(
                  productId: productId,
                  action: selectedAction!,
                  quantity: quantity,
                  note: note,
                );
                Get.back();
              } else {
                Get.snackbar(
                  "กรุณากรอกให้ครบ",
                  "โปรดเลือกสินค้าและประเภทการเคลื่อนไหว",
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Text("บันทึก"),
          ),
        ],
      ),
    );
  }
}
