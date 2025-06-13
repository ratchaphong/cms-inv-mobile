import 'package:cms_inv_mobile/shared/enums/product_status.dart';

class ProductRequest {
  final String category;
  final String name;
  final int initialStock;
  final ProductStatus status;

  ProductRequest({
    required this.category,
    required this.name,
    required this.initialStock,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'initialStock': initialStock,
      'status': status.value,
    };
  }
}
