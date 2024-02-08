class CartItem {
  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      productId: map['productId'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
    );
  }
}
