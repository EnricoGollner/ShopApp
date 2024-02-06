import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/orders/models/order.dart';

class OrderViewModel with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  void addOrder(CartViewModel newCart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: newCart.totalAmount,
        products: newCart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
