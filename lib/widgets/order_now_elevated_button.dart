
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order_provider.dart';

class orderNowElevatedButton extends StatefulWidget {
  const orderNowElevatedButton({
    required this.cartItem,
  });

  final Cart cartItem;

  @override
  State<orderNowElevatedButton> createState() => _orderNowElevatedButtonState();
}

class _orderNowElevatedButtonState extends State<orderNowElevatedButton> {
  var _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return _showLoader ? const CircularProgressIndicator(
      color: Colors.amber,
    ) : ElevatedButton(
        onPressed: widget.cartItem.totalAmount <= 0
            ? null
            : () async {
                try {
                  setState(() {
                    _showLoader = true;
                  });
                  await Provider.of<OrderProvider>(context, listen: false)
                      .addOrder(
                    widget.cartItem.items.values.toList(),
                    widget.cartItem.totalAmount,
                    DateTime.now(),
                  );
                  widget.cartItem.clear();
                } catch (error) {
                  await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text('Something wrong'),
                            content: const Text('Please try again'),
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ))
                            ],
                          ));
                }
                setState(() {
                  _showLoader = false;
                });
              },
        child:  Text('Order Now'));
  }
}
