import 'package:flutter/material.dart';

class CartItem {
  final String? id;
  final String? title;
  final double? price;
  final int? quantity;

  CartItem.name(this.id, this.title, this.price, this.quantity);
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (oldItem) => CartItem.name(
            oldItem.id, oldItem.title, oldItem.price, oldItem.quantity! + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem.name(DateTime.now().toString(), title, price, 1),
      );
    }
    notifyListeners();
  }

  int getCartCount() {
    int count = 0;
    _items.forEach((key, value) {
      count += value.quantity!;
    });
    return count;
  }

  double get totalAmount {
    double totalAmount = 0.0;
    _items.forEach((key, value) {
      totalAmount += value.price! * value.quantity!;
    });
    return totalAmount;
  }

  void removeItem(String productid){
    _items.remove(productid);
    notifyListeners();
  }

  void clear(){
    _items.clear();
    notifyListeners();
  }
}
