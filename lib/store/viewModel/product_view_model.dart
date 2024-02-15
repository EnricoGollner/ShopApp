import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/core/exceptions/http_exception.dart';
import 'package:shop/service/store_service.dart';
import 'package:shop/store/models/product.dart';

class ProductViewModel with ChangeNotifier {
  String token;
  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((item) => item.isFavorite).toList();

  final StoreService _httpService = StoreService();

  ProductViewModel(this.token, List<Product> items) {
    _items.clear();
    _items.addAll(items);
  }

  Future<void> loadProducts() async {
    _items.clear();

    final Response response = await _httpService.get(uri: 'products.json?auth=$token');
    if (response.body == 'null' || response.statusCode >= 400) {
      throw HTTPException(message: 'Error requesting list of products!', statusCode: response.statusCode);
    }

    jsonDecode(response.body).forEach((key, productData) {
      _items.add(Product.fromMap(key, productData));
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, dynamic> data) async {
    final Product product = Product.fromMap(data['id'] ?? Random().nextDouble().toString(), data);

    if (data['id'] != null) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  Future<void> addProduct(Product newProduct) async {
    final Response response = await _httpService.post(
        bodyJson: jsonEncode(newProduct.toMap()),
        uriPath: 'products.json');

    final id = jsonDecode(response.body)['title'];
    _items.add(newProduct.copyWith(id: id));
    notifyListeners();
  }

  Future<void> updateProduct(Product updatedProduct) async {
    int index = _items.indexWhere((product) => product.id == updatedProduct.id);

    if (index >= 0) {
      await _httpService.patch(
        uri: '${updatedProduct.id}.json',
        bodyJson: jsonEncode({
          'title': updatedProduct.title,
          'description': updatedProduct.description,
          'price': updatedProduct.price,
          'urlImage': updatedProduct.urlImage,
        }),
      );

      _items[index] = updatedProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct({required String productId}) async {
    int index = _items.indexWhere((product) => product.id == productId);

    if (index >= 0) {
      final Product product = _items[index];

      _items.removeWhere((product) => product.id == productId);
      notifyListeners();

      final Response response = await _httpService.delete(uri: '$productId.json');

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HTTPException(message: 'Couldn´t delete the product ${product.title}', statusCode: response.statusCode);
      }      
    }
  }
}
