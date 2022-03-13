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
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),
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
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(productId);
                } catch (error) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text('Delete Failed'),
                    ),
                  );
                }
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
