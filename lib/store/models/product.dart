// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:shop/core/exceptions/http_exception.dart';
import 'package:shop/service/http_service.dart';

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

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    _toggleFavorite();

    final Response response = await HTTPService().delete(uri: '$id.json');

    if (response.statusCode >= 400) {
      _toggleFavorite();
      throw HTTPException(
          message: "Couldn't add this product to your favorites list",
          statusCode: response.statusCode);
    }
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'urlImage': urlImage,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      urlImage: map['urlImage'] as String,
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
