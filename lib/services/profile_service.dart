import 'dart:convert';
import 'package:cms_inv_mobile/models/entities/user_profile_model.dart';
import 'package:cms_inv_mobile/models/requests/edit_profile_request.dart';
import 'package:cms_inv_mobile/shared/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../shared/config.dart';
import 'package:get_storage/get_storage.dart';

class ProfileService {
  final box = GetStorage();

  Future<UserProfileModel?> fetchProfile() async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      return UserProfileModel(
        id: '1',
        name: 'Demo User',
        email: 'demo@bstore.com',
        phoneNumber: '012-345-6789',
        gender: 'other',
        birthDate: DateTime(1990, 1, 1),
        avatarUrl: null,
        address: '999/9 Demo Street, Bangkok',
        role: 'user',
      );
    }

    try {
      final token = box.read<String>('token') ?? '';
      final res = await http.get(
        Uri.parse('$baseUrl/users/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        return UserProfileModel.fromJson(jsonDecode(res.body));
      } else {
        if (kDebugMode) {
          print('🔴 fetchProfile failed: ${res.statusCode} → ${res.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) print('❌ fetchProfile error: $e');
    }
    return null;
  }

  Future<UserProfileModel?> updateProfile(EditProfileRequest req) async {
    if (isDemoMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      return UserProfileModel(
        id: req.userId,
        name: req.name,
        email: req.email,
        phoneNumber: req.phoneNumber,
        gender: 'other',
        birthDate: DateTime(1990, 1, 1),
        avatarUrl: req.avatarUrl,
        address: req.address,
        role: 'user',
      );
    }
    try {
      final token = box.read<String>('token') ?? '';
      final res = await http.patch(
        Uri.parse('$baseUrl/users/${req.userId}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(req.toJson()),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        return UserProfileModel.fromJson(jsonDecode(res.body));
      } else {
        if (kDebugMode) {
          print('🔴 updateProfile failed: ${res.statusCode} → ${res.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) print('❌ updateProfile error: $e');
    }
    return null;
  }
}
