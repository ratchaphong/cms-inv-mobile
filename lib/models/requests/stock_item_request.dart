// lib/models/requests/stock_item_request.dart
import 'package:cms_inv_mobile/shared/enums/stock_action.dart';

class StockItemRequest {
  final int productId;
  final StockAction type;
  final int quantity;
  final String? note;

  StockItemRequest({
    required this.productId,
    required this.type,
    required this.quantity,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'type': type.value,
      'quantity': quantity,
      'note': note,
    };
  }
}
