import 'package:shop/cart/models/cart_item.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });

  factory Order.fromMap(String id, Map<String, dynamic> map) {
    return Order(
      id: id,
      total: map['total'] as double,
      products: (map['products'] as List)
          .map<CartItem>(
            (x) => CartItem.fromMap(x as Map<String, dynamic>),
          ).toList(),
      date: DateTime.parse(map['date']),
    );
  }
}
