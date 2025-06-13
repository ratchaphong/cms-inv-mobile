enum ProductStatus {
  available,
  lowStock,
  outOfStock,
}

extension ProductStatusExtension on ProductStatus {
  /// คืนค่าสตริงที่ใช้ส่งไปยัง API (CONSTANT_CASE)
  String get value {
    switch (this) {
      case ProductStatus.available:
        return "AVAILABLE";
      case ProductStatus.lowStock:
        return "LOW_STOCK";
      case ProductStatus.outOfStock:
        return "OUT_OF_STOCK";
    }
  }

  String get label {
    switch (this) {
      case ProductStatus.available:
        return "AVAILABLE";
      case ProductStatus.lowStock:
        return "LOW STOCK";
      case ProductStatus.outOfStock:
        return "OUT OF STOCK";
    }
  }

  /// แปลงจากสตริง (CONSTANT_CASE) กลับเป็น enum
  static ProductStatus fromString(String status) {
    switch (status) {
      case "AVAILABLE":
        return ProductStatus.available;
      case "LOW_STOCK":
        return ProductStatus.lowStock;
      case "OUT_OF_STOCK":
        return ProductStatus.outOfStock;
      default:
        throw ArgumentError("Invalid ProductStatus: $status");
    }
  }
}
