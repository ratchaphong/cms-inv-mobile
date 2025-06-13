import 'dart:convert';
import 'package:cms_inv_mobile/models/entities/product_model.dart';
import 'package:cms_inv_mobile/models/requests/product_request.dart';
import 'package:cms_inv_mobile/shared/enums/product_status.dart';
import 'package:cms_inv_mobile/shared/config.dart';
import 'package:cms_inv_mobile/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

class ProductsService {
  final box = GetStorage();

  Future<List<ProductModel>> fetchProducts() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      return [
        ProductModel(
          id: 1,
          name: 'Demo Product 1',
          category: 'หมวด A',
          currentStock: 10,
          status: ProductStatus.available,
        ),
        ProductModel(
          id: 2,
          name: 'Demo Product 2',
          category: 'หมวด B',
          currentStock: 3,
          status: ProductStatus.lowStock,
        ),
        ProductModel(
          id: 3,
          name: 'Demo Product 3',
          category: 'หมวด C',
          currentStock: 0,
          status: ProductStatus.outOfStock,
        ),
      ];
    }

    try {
      final token = box.read<String>('token') ?? '';
      final response = await http.get(
        Uri.parse('$baseUrl/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        if (kDebugMode) {
          print(
              '🔴 fetchProducts failed: ${response.statusCode} → ${response.body}');
        }
        throw Exception("Failed to fetch stock items");
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ fetchProducts error: $e');
      }
      rethrow;
    }
  }

  Future<ProductModel> addProduct(ProductRequest newProduct) async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      return ProductModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: newProduct.name,
        category: newProduct.category,
        currentStock: newProduct.initialStock,
        status: newProduct.status,
      );
    }

    try {
      final token = box.read<String>('token') ?? '';
      final response = await http.post(
        Uri.parse('$baseUrl/products'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(newProduct.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ProductModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ addProduct error: $e');
      }
      rethrow;
    }
  }
}
