import 'package:cms_inv_mobile/models/responses/dashboard_stats_response.dart';
import 'package:cms_inv_mobile/services/dashboard_service.dart';
import 'package:get/get.dart';

class DashboardViewModel extends GetxController {
  final isLoading = false.obs;
  final stats = Rxn<DashboardStatsResponse>();

  final dashboardService = Get.find<DashboardService>();

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  void fetchStats() async {
    isLoading.value = true;
    final result = await dashboardService.fetchDashboardStats();
    stats.value = result;
    isLoading.value = false;
  }
}
