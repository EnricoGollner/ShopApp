import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String urlImage;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.urlImage,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? urlImage,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      urlImage: urlImage ?? this.urlImage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      urlImage: map['urlImage'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }
}
