import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProcuctView extends StatelessWidget {
  final productId;
  final title;
  final imageurl;

  UserProcuctView.name(this.productId, this.title, this.imageurl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.network(
            imageurl,
            fit: BoxFit.fill,
          ),
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName,
                    arguments: productId);
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Provider.of<ProductsProvider>(context).deleteProduct(productId);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
