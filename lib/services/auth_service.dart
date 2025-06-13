import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../shared/constants.dart';
import '../../shared/config.dart';
import '../models/requests/login_request.dart';
import '../models/responses/login_response.dart';
import '../models/requests/register_request.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  final box = GetStorage(); // ✅ ใช้ได้ทั้งคลาส

  Future<LoginResponse?> login(LoginRequest req) async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 500));

      // ✅ บันทึก token และ loginTime ลง storage
      box.write('token', 'demo-token-xyz');
      box.write('loginTime', DateTime.now().millisecondsSinceEpoch);

      return LoginResponse(token: 'demo-token-xyz');
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(req.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(data);

        // ✅ บันทึก token และ loginTime
        box.write('token', loginResponse.token);
        box.write('loginTime', DateTime.now().millisecondsSinceEpoch);

        return loginResponse;
      } else {
        if (kDebugMode) {
          print('🔴 Login failed: ${response.statusCode} → ${response.body}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Login exception: $e');
      }
      return null;
    }
  }

  Future<bool> register(RegisterRequest req) async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 500));
      return true;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(req.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        if (kDebugMode) {
          print(
              '🔴 Register failed: ${response.statusCode} → ${response.body}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Register exception: $e');
      }
      return false;
    }
  }
}
