import 'package:cms_inv_mobile/models/entities/stock_report_model.dart';
import 'package:cms_inv_mobile/services/stocks_report_service.dart';
import 'package:get/get.dart';

class StocksReportViewModel extends GetxController {
  final _service = Get.find<StocksReportService>();

  var reports = <StockReportModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadReports();
  }

  Future<void> loadReports() async {
    isLoading.value = true;
    try {
      reports.assignAll(await _service.fetchReports());
    } catch (_) {
      Get.snackbar('Error', 'ไม่สามารถโหลดรายงานได้');
    } finally {
      isLoading.value = false;
    }
  }
}
