
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order_provider.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}
class _OrderScreenState extends State<OrderScreen> {
  var _showLoader = false;

  @override
  void initState() {

    Future.delayed(Duration.zero).then((value) async{
     await Provider.of<OrderProvider>(context, listen: false).getAndSetOrder();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context).items;
    return Scaffold(
        appBar: AppBar(
          title: Text('Order'),
        ),
        body: _showLoader ? Center(child: CircularProgressIndicator()) :ListView.builder(
          itemBuilder: (ctx, index) {
            return OrderItem(order[index]);
          },
          itemCount: order.length,
        ));
  }
}
