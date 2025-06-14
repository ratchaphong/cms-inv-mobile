import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

/// A reusable avatar widget that can display images from various sources:
/// - Data URI (base64)
/// - Network URL
/// - Local file path
/// - Fallback asset image
class AvatarImage extends StatelessWidget {
  /// The image source input. It can be:
  /// - Data URI: "data:image/png;base64,..."
  /// - Base64 string
  /// - Network URL: "http..."
  /// - Local file path
  final String? source;

  /// Radius of the avatar circle.
  final double radius;

  /// Fallback asset path if no valid source provided.
  final String fallbackAsset;

  const AvatarImage({
    Key? key,
    required this.source,
    this.radius = 48.0,
    this.fallbackAsset = 'assets/images/bstore.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: _resolveImageProvider(source),
    );
  }

  ImageProvider<Object> _resolveImageProvider(String? input) {
    if (input != null) {
      // Data URI: data:image/...;base64,...
      if (input.startsWith('data:image')) {
        final base64Str = input.split(',').last;
        try {
          final bytes = base64Decode(base64Str);
          return MemoryImage(bytes);
        } catch (_) {}
      }
      // Pure base64 string
      if (RegExp(r'^[A-Za-z0-9+/=]+\\$').hasMatch(input)) {
        try {
          final bytes = base64Decode(input);
          return MemoryImage(bytes);
        } catch (_) {}
      }
      // Network URL
      if (input.startsWith('http')) {
        return NetworkImage(input);
      }
      // Local file path
      try {
        final file = File(input);
        if (file.existsSync()) {
          return FileImage(file);
        }
      } catch (_) {}
    }
    // Fallback asset image
    return AssetImage(fallbackAsset);
  }
}
