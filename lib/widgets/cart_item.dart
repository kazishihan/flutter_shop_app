import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final id;
  final productid;
  final title;
  final price;
  final quantity;

  CartItem(this.id, this.productid, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(productid);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('\$${price}'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('total ${price! * quantity}'),
            trailing: Text('${quantity}x'),
          ),
        ),
      ),
    );
  }
}
