import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shop_app/providers/cart.dart';

class Order {
  final id;
  final totalAmount;
  final date;
  final cartItem;

  Order.name(this.id, this.totalAmount, this.date, this.cartItem);
}

class OrderProvider with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  Future<void> addOrder(
      List<CartItem> cartItems, final totalAmount, final id) async {
    final url = Uri.parse('https://dclean-b69ee.firebaseio.com/orders.json');
    final curentDate = DateTime.now();
    try {
      final response = await http.post(url,
          body: jsonEncode({
            'totalAmount': totalAmount,
            'cartItem': cartItems
                .map((cp) => {
                      'title': cp.title,
                      'id': cp.id,
                      'price': cp.price,
                      'quantity': cp.quantity
                    })
                .toList(),
            'date': curentDate.toIso8601String(),
          }));

      _items.insert(
          0,
          Order.name(json.decode(response.body)['name'], totalAmount,
              curentDate.toIso8601String(), cartItems));
      notifyListeners();
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<void> getAndSetOrder() async {
    final url = Uri.parse('https://dclean-b69ee.firebaseio.com/orders.json');
    final response = await http.get(url);
    final responseData = json.decode(response.body) as Map<String, dynamic>;
    if (responseData == null) {
      return;
    }
    List<Order> orderList = [];
    responseData.forEach((orderid, value) {
      print(orderid);
      orderList.add(Order.name(
        orderid,
        value['totalAmount'],
        DateTime.parse(value['date']),
        (value['cartItem'] as List<dynamic>)
            .map((e) => CartItem.name(
                  e['id'],
                  e['title'],
                  e['price'],
                  e['quantity'],
                ))
            .toList(),
      ));
    });
    _items = orderList;
    notifyListeners();
  }
}
