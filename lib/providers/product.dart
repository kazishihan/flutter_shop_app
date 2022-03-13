import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool? isFavorite = false;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.isFavorite,
  });

  Future<void> toggleFavorite() async {
    final url =
        Uri.parse('https://dclean-b69ee.firebaseio.com/product/$id.json');
    bool? currentFavState = isFavorite ?? false;
    isFavorite = !currentFavState;
    notifyListeners();
    final response =
        await http.patch(url, body: jsonEncode({'isFavorite': isFavorite}));
    if (response.statusCode >= 400) {
      isFavorite = currentFavState;
      notifyListeners();
    }
    currentFavState = null;
  }
}
