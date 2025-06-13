import 'package:cms_inv_mobile/modules/stocks_report/stocks_report_view_model.dart';
import 'package:cms_inv_mobile/services/stocks_report_service.dart';
import 'package:get/get.dart';

class StocksReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StocksReportService());
    Get.lazyPut(() => StocksReportViewModel());
  }
}
