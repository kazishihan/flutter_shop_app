import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItem {
    return _items.where((element) => element.isFavorite ?? false).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> getAndSetProduct() async {
    final url = Uri.parse('https://dclean-b69ee.firebaseio.com/product.json');
    try {
      final response = await http.get(url);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      List<Product> productDataList = [];
      responseData.forEach((prodId, value) {
        productDataList.add(Product(
            id: prodId,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavorite: value['isFavorite']));
      });
      _items = productDataList;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addproduct(Product product) async {
    final url = Uri.parse('https://dclean-b69ee.firebaseio.com/product.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'id': DateTime.now().toString(),
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        }),
      );
      final id = jsonDecode(response.body)[''];
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (exception) {
      rethrow;
    }
  }

  Future<void> updateproduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          Uri.parse('https://dclean-b69ee.firebaseio.com/product/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        Uri.parse('https://dclean-b69ee.firebaseio.com/product/$id.json');
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('colud not delete product');
    }
    existingProduct = null;
  }

}
