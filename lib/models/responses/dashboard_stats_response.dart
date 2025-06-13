import 'package:cms_inv_mobile/models/entities/available_product_model.dart';

class DashboardStatsResponse {
  final int totalProducts;
  final int stockInToday;
  final int stockOutToday;
  final int totalUsers;
  final List<AvailableProduct> availableProducts;

  DashboardStatsResponse({
    required this.totalProducts,
    required this.stockInToday,
    required this.stockOutToday,
    required this.totalUsers,
    required this.availableProducts,
  });

  factory DashboardStatsResponse.fromJson(Map<String, dynamic> json) {
    return DashboardStatsResponse(
      totalProducts: json['totalProducts'] ?? 0,
      stockInToday: json['stockInToday'] ?? 0,
      stockOutToday: json['stockOutToday'] ?? 0,
      totalUsers: json['totalUsers'] ?? 0,
      availableProducts: (json['availableProducts'] as List<dynamic>? ?? [])
          .map((e) => AvailableProduct.fromJson(e))
          .toList(),
    );
  }
}
