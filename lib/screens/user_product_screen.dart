import 'package:flutter/material.dart';
import 'package:shop_app/screens/main_draware.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_procuct_view.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-product-screen';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: productProvider.items.length,
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              UserProcuctView.name(
                productProvider.items[index].id,
                productProvider.items[index].title,
                productProvider.items[index].imageUrl,
              ),
              Divider(
                color: Colors.black87,
              )
            ],
          );
        },
      ),
    );
  }
}
