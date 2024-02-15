import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/core/exceptions/http_exception.dart';
import 'package:shop/orders/models/order.dart';
import 'package:shop/service/store_service.dart';

class OrderViewModel with ChangeNotifier {
  final String _token;
  final String _userId;
  List<Order> _orders = [];
  final StoreService _httpService = StoreService();

  final DateTime date = DateTime.now();
  List<Order> get items => [..._orders];

  int get itemsCount => _orders.length;

  OrderViewModel([this._token = '', this._userId = '', this._orders = const []]);

  Future<void> loadOrders() async {
    List<Order> orders = [];
    
    final Response response = await _httpService.get(uri: 'orders/$_userId.json?auth=$_token');

    if (response.statusCode >= 400) {
      throw HTTPException(statusCode: response.statusCode, message: 'Error getting orders!');
    } else if (response.body == 'null' ) {
      throw HTTPException(message: 'No orders registered yet!', statusCode: 200);
    }

    jsonDecode(response.body).forEach((id, order) {
      orders.add(Order.fromMap(id, order));
    });

    _orders = orders.reversed.toList();  // Recent orders will be shown first now
    notifyListeners();
  }

  Future<void> addOrder(CartViewModel newCart) async {
    final Response response = await _httpService.post(
        uriPath: 'orders/$_userId.json?auth=$_token',
        bodyJson: jsonEncode({
          'total': newCart.totalAmount,
          'date': date.toIso8601String(),
          'products': newCart.items.values.map(
            (cartItem) => cartItem.toMap()
          ).toList(),
        },
      ),
    );

    _orders.insert(
      0,
      Order(
        id: jsonDecode(response.body)['name'],
        total: newCart.totalAmount,
        date: date,
        products: newCart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
