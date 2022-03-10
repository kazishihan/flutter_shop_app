import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';


  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      body: ListView.builder(itemBuilder: (ctx,index)
      {
        return OrderItem(order[index]);
      },
      itemCount: order.length,
      )
    );
  }
}
