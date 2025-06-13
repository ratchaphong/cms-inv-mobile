import 'package:cms_inv_mobile/shared/enums/product_status.dart';

class ProductModel {
  final int id;
  final String name;
  final String category;
  final int currentStock;
  final ProductStatus status;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.currentStock,
    required this.status,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      currentStock: json['currentStock'],
      status: ProductStatusExtension.fromString(json['status']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'category': category,
  //     'currentStock': currentStock,
  //     'status': status.value,
  //   };
  // }

  // ProductModel copyWith({
  //   int? id,
  //   String? name,
  //   String? category,
  //   int? currentStock,
  //   ProductStatus? status,
  // }) {
  //   return ProductModel(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     category: category ?? this.category,
  //     currentStock: currentStock ?? this.currentStock,
  //     status: status ?? this.status,
  //   );
  // }
}
