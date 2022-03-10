import 'package:flutter/material.dart';

class Order {
  final id;
  final totalAmount;
  final date;
  final cartItem;

  Order.name(this.id, this.totalAmount, this.date, this.cartItem);
}

class OrderProvider with ChangeNotifier{
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void addOrder(final cartItems, final totalAmount, final id) {
    _items.insert(0, Order.name(id, totalAmount, DateTime.now(), cartItems));
  }
}
