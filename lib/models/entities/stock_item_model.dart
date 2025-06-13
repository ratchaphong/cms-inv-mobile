import 'package:cms_inv_mobile/shared/enums/stock_action.dart';
import 'product_model.dart';

class StockItemModel {
  final String id;
  final ProductModel product;
  final int quantity;
  final StockAction type;
  final DateTime createdAt;
  final String? note;

  StockItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.type,
    required this.createdAt,
    this.note,
  });

  factory StockItemModel.fromJson(Map<String, dynamic> json) {
    return StockItemModel(
      id: json['id'].toString(),
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      type: StockActionExtension.fromString(json['type']),
      createdAt: DateTime.parse(json['createdAt']),
      note: json['note'],
    );
  }
}
