import 'dart:convert';
import 'package:cms_inv_mobile/models/entities/product_model.dart';
import 'package:cms_inv_mobile/models/entities/stock_report_model.dart';
import 'package:cms_inv_mobile/shared/config.dart';
import 'package:cms_inv_mobile/shared/constants.dart';
import 'package:cms_inv_mobile/shared/enums/product_status.dart';
import 'package:cms_inv_mobile/shared/enums/stock_action.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class StocksReportService {
  final box = GetStorage();

  Future<List<StockReportModel>> fetchReports() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      final now = DateTime.now();

      return [
        StockReportModel(
          id: 1,
          type: StockAction.incoming,
          quantity: 50,
          note: 'สต็อกเริ่มต้น',
          createdAt: now.subtract(const Duration(days: 7)),
          archivedAt: now,
          product: ProductModel(
            id: 1,
            name: 'สินค้า A',
            category: 'หมวด A',
            currentStock: 150,
            status: ProductStatus.available,
          ),
        ),
        StockReportModel(
          id: 2,
          type: StockAction.outgoing,
          quantity: 20,
          note: 'ขายสินค้า',
          createdAt: now.subtract(const Duration(days: 3)),
          archivedAt: now.subtract(const Duration(days: 2)),
          product: ProductModel(
            id: 2,
            name: 'สินค้า B',
            category: 'หมวด B',
            currentStock: 80,
            status: ProductStatus.available,
          ),
        ),
      ];
    }

    try {
      final token = box.read<String>('token') ?? '';
      final res = await http.get(
        Uri.parse('$baseUrl/stocks/report/archived'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> list = jsonDecode(res.body);
        return list
            .map((e) => StockReportModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        if (kDebugMode) {
          print('🔴 fetchReports failed: '
              '${res.statusCode} → ${res.body}');
        }
        throw Exception('Failed to load reports (status ${res.statusCode})');
      }
    } catch (e, st) {
      if (kDebugMode) {
        print('❌ fetchReports exception: $e');
        print(st);
      }
      rethrow;
    }
  }
}
