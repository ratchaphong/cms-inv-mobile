import 'dart:convert';
import 'package:cms_inv_mobile/models/entities/product_model.dart';
import 'package:cms_inv_mobile/models/entities/stock_item_model.dart';
import 'package:cms_inv_mobile/models/requests/stock_item_request.dart';
import 'package:cms_inv_mobile/shared/config.dart';
import 'package:cms_inv_mobile/shared/constants.dart';
import 'package:cms_inv_mobile/shared/enums/product_status.dart';
import 'package:cms_inv_mobile/shared/enums/stock_action.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class StocksService {
  final box = GetStorage();

  Future<List<StockItemModel>> fetchStockItems() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      final now = DateTime.now();
      return [
        StockItemModel(
          id: 's1',
          product: ProductModel(
            id: 1,
            name: 'กระดาษ A4',
            category: 'เครื่องเขียน',
            currentStock: 100,
            status: ProductStatus.available,
          ),
          quantity: 20,
          type: StockAction.incoming,
          createdAt: now.subtract(const Duration(hours: 2)),
          note: 'นำเข้าเพื่อต้นทุนเริ่ม',
        ),
        StockItemModel(
          id: 's2',
          product: ProductModel(
            id: 2,
            name: 'ปากกาเจล',
            category: 'เครื่องเขียน',
            currentStock: 50,
            status: ProductStatus.lowStock,
          ),
          quantity: 5,
          type: StockAction.outgoing,
          createdAt: now.subtract(const Duration(days: 1, hours: 3)),
          note: 'จำหน่ายลูกค้าสาขา 2',
        ),
        StockItemModel(
          id: 's3',
          product: ProductModel(
            id: 3,
            name: 'แฟ้มเอกสาร',
            category: 'เครื่องเขียน',
            currentStock: 0,
            status: ProductStatus.outOfStock,
          ),
          quantity: 10,
          type: StockAction.outgoing,
          createdAt: now.subtract(const Duration(days: 3)),
          note: null,
        ),
      ];
    }

    try {
      final token = box.read<String>('token') ?? '';

      final response = await http.get(
        Uri.parse('$baseUrl/stocks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => StockItemModel.fromJson(e)).toList();
      } else {
        if (kDebugMode) {
          print(
              '🔴 fetchStockItems failed: ${response.statusCode} → ${response.body}');
        }
        throw Exception('Failed to fetch stock items');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ fetchStockItems error: $e');
      }
      rethrow;
    }
  }

  Future<StockItemModel> addStockItem(StockItemRequest req) async {
    if (isDemoMode) {
      final now = DateTime.now();
      return StockItemModel(
        id: now.millisecondsSinceEpoch.toString(),
        product: ProductModel(
          id: req.productId,
          name: 'Demo',
          category: '',
          currentStock: 0,
          status: ProductStatus.available,
        ),
        quantity: req.quantity,
        type: req.type,
        createdAt: now,
        note: req.note,
      );
    }

    try {
      final token = box.read<String>('token') ?? '';
      final response = await http.post(
        Uri.parse('$baseUrl/stocks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(req.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return StockItemModel.fromJson(jsonDecode(response.body));
      } else {
        if (kDebugMode) {
          print('🔴 addStockItem failed: '
              '${response.statusCode} → ${response.body}');
        }
        throw Exception('Failed to add stock item: '
            'status=${response.statusCode}');
      }
    } catch (e, st) {
      if (kDebugMode) {
        print('❌ addStockItem exception: $e');
        print(st);
      }
      rethrow;
    }
  }
}
