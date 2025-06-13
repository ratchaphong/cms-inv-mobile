class AvailableProduct {
  final int id;
  final String name;
  final int quantity;

  AvailableProduct(
      {required this.id, required this.name, required this.quantity});

  factory AvailableProduct.fromJson(Map<String, dynamic> json) {
    return AvailableProduct(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }
}
