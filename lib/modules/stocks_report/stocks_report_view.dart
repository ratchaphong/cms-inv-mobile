import 'package:cms_inv_mobile/models/entities/stock_report_model.dart';
import 'package:cms_inv_mobile/shared/enums/stock_action.dart';
import 'package:cms_inv_mobile/shared/widgets/app_drawer.dart';
import 'package:cms_inv_mobile/shared/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'stocks_report_view_model.dart';

class StocksReportView extends StatelessWidget {
  const StocksReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<StocksReportViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'รายงานสต็อก (รายสัปดาห์)'),
      drawer: const AppDrawer(),
      body: Obx(() {
        if (vm.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (vm.reports.isEmpty) {
          return Center(
              child:
                  Text('ไม่มีข้อมูลรายงาน', style: theme.textTheme.bodyMedium));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: vm.reports.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (ctx, i) => _buildReportCard(vm.reports[i], theme),
        );
      }),
    );
  }

  Widget _buildReportCard(StockReportModel r, ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(r.product.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(children: [
            Text('ประเภท: ', style: theme.textTheme.bodySmall),
            Text(r.type.label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 16),
            Text('จำนวน: ${r.quantity}', style: theme.textTheme.bodySmall),
          ]),
          const SizedBox(height: 8),
          Text('หมายเหตุ: ${r.note ?? "-"}', style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          Text(
            'สร้าง: ${DateFormat('dd/MM/yyyy').format(r.createdAt)}',
            style: theme.textTheme.bodySmall,
          ),
          Text(
            'ลบ: ${DateFormat('dd/MM/yyyy').format(r.archivedAt)}',
            style: theme.textTheme.bodySmall,
          ),
        ]),
      ),
    );
  }
}
