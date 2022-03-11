import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order_provider.dart';

class OrderItem extends StatefulWidget {
  final Order orderdata;

  OrderItem(this.orderdata);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpand = false;

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = widget.orderdata.cartItem as List<CartItem>;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$ ' +
                NumberFormat('###.0#').format(widget.orderdata.totalAmount)),
            subtitle: Text(DateFormat.yMd().format(widget.orderdata.date)),
            trailing: IconButton(
              icon: Icon(_isExpand ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpand = !_isExpand;
                });
              },
            ),
          ),
          if (_isExpand)
            Container(
              height: min(cartItems.length * 10.0 + 80, 100),
              padding: EdgeInsets.all(8),
              child: ListView(
                children: cartItems
                    .map((e) => Row(
                          children: [Text(e.title!)],
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
