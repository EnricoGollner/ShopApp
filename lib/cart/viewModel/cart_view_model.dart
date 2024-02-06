import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/cart/models/cart_item.dart';
import 'package:shop/store/models/product.dart';

class CartViewModel with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => {..._items};

  int get itemsCount => _items.length;

  double get totalAmount {
    double totalAmount = 0.0;
    _items.forEach((key, cartItem) {
      totalAmount += (cartItem.price * cartItem.quantity);
    });

    return totalAmount;
  }

  void addItem(Product newProduct) {
    if (_items.containsKey(newProduct.id)) {
      _items.update(
        newProduct.id,
        (existingItem) =>
            existingItem.copyWith(quantity: existingItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
        newProduct.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: newProduct.id,
          name: newProduct.title,
          quantity: 1,
          price: newProduct.price,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => existingItem.copyWith(quantity: existingItem.quantity - 1),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
