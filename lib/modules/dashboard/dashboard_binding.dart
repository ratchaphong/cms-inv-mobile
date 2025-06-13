import 'package:cms_inv_mobile/modules/dashboard/dashboard_view_model.dart';
import 'package:cms_inv_mobile/services/dashboard_service.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardService>(
        () => DashboardService()); // ✅ Register service
    Get.lazyPut<DashboardViewModel>(() => DashboardViewModel()); // ✅ ViewModel
  }
}
