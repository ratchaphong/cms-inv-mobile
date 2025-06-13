import 'dart:convert';
import 'package:cms_inv_mobile/models/entities/available_product_model.dart';
import 'package:cms_inv_mobile/models/responses/dashboard_stats_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../shared/constants.dart';
import '../../shared/config.dart';
import 'package:get_storage/get_storage.dart';

class DashboardService {
  final box = GetStorage();

  Future<DashboardStatsResponse?> fetchDashboardStats() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 500));
      return DashboardStatsResponse(
        totalProducts: 100,
        stockInToday: 20,
        stockOutToday: 10,
        totalUsers: 5,
        availableProducts: [
          AvailableProduct(id: 1, name: 'กระดาษ A4', quantity: 50),
          AvailableProduct(id: 2, name: 'ปากกาเจลสีดำ', quantity: 120),
          AvailableProduct(id: 3, name: 'แฟ้มเอกสารใส', quantity: 35),
          AvailableProduct(id: 4, name: 'กล่องเก็บของขนาดเล็ก', quantity: 12),
          AvailableProduct(id: 5, name: 'เทปกาว 2 หน้า', quantity: 80),
        ],
      );
    }

    try {
      final token = box.read<String>('token') ?? '';
      final response = await http.get(
        Uri.parse('$baseUrl/dashboard/stats'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return DashboardStatsResponse.fromJson(json);
      }

      return null;
    } catch (e) {
      if (kDebugMode) print("❌ Dashboard error: $e");
      return null;
    }
  }
}
