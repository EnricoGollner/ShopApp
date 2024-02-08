import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop/service/http_service.dart';
import 'package:shop/store/models/product.dart';

class ProductViewModel with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((item) => item.isFavorite).toList();
  final HttpService _httpService = HttpService();

  Future<void> loadProducts() async {
    _items.clear();

    final Response response = await _httpService.get(uri: 'products.json');
    if (response.body == 'null') {
      throw Exception('Error requesting list of products');
    }

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, productData){
      _items.add(
        Product.fromMap(key, productData)
      );
    });

    notifyListeners();
  }

  Future<void> saveProduct(Map<String, dynamic> data) async {
    final Product product = Product(
      id: data['id'] ?? Random().nextDouble().toString(),
      title: data['name'],
      description: data['description'],
      price: data['price'],
      urlImage: data['urlImage'],
    );

    if (data['id'] != null) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  Future<void> addProduct(Product newProduct) async {
    final Response response = await _httpService.post(
        bodyJson: jsonEncode({
          "name": newProduct.title,
          "description": newProduct.description,
          "price": newProduct.price,
          "imageUrl": newProduct.urlImage,
          "isFavorite": newProduct.isFavorite,
        }),
        uriPath: 'products.json');

    final id = jsonDecode(response.body)['name'];
    _items.add(newProduct.copyWith(id: id));
    notifyListeners();
  }

  Future<void> updateProduct(Product updatedProduct) async {
    int index = _items.indexWhere((product) => product.id == updatedProduct.id);

    if (index >= 0) {
      _items[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct({required String id}) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
