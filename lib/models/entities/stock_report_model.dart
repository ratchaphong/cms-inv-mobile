import 'package:cms_inv_mobile/shared/enums/stock_action.dart';

import 'product_model.dart';

class StockReportModel {
  final int id;
  final StockAction type;
  final int quantity;
  final String? note;
  final ProductModel product;
  final DateTime createdAt;
  final DateTime archivedAt;

  StockReportModel({
    required this.id,
    required this.type,
    required this.quantity,
    this.note,
    required this.product,
    required this.createdAt,
    required this.archivedAt,
  });

  factory StockReportModel.fromJson(Map<String, dynamic> json) {
    return StockReportModel(
      id: json['id'] as int,
      type: StockActionExtension.fromString(json['type'] as String),
      quantity: json['quantity'] as int,
      note: json['note'] as String?,
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      archivedAt: DateTime.parse(json['archivedAt'] as String),
    );
  }
}
