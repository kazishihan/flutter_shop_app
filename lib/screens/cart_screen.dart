import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/order_now_elevated_button.dart';
import 'package:shop_app/widgets/cart_item.dart' as cartWidg;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Items',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      '\$${cartItem.totalAmount}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  orderNowElevatedButton(cartItem: cartItem),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cartItem.items.length,
                itemBuilder: (ctx, index) => cartWidg.CartItem(
                    cartItem.items.values.toList()[index].id,
                    cartItem.items.keys.toList()[index],
                    cartItem.items.values.toList()[index].title,
                    cartItem.items.values.toList()[index].price,
                    cartItem.items.values.toList()[index].quantity)),
          ),
        ],
      ),
    );
  }
}
