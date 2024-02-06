import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/core/utils/dummy_data.dart';
import 'package:shop/store/models/product.dart';

class ProductViewModel with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((item) => item.isFavorite).toList();

  void saveProduct(Map<String, dynamic> data) {
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

  void addProduct(Product newProduct) {
    _items.add(newProduct);
    notifyListeners();
  }
  
  void updateProduct(Product updatedProduct) {
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
