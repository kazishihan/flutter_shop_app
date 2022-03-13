import 'package:flutter/material.dart';
import 'package:shop_app/screens/main_draware.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_procuct_view.dart';
import 'edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-product-screen';

  Future<void> _refreshProductData(BuildContext context) async{
    await Provider.of<ProductsProvider>(context,listen: false).getAndSetProduct();
  }

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
      body: RefreshIndicator(
        onRefresh: ()=>_refreshProductData(context),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView.builder(
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
        ),
      ),
    );
  }
}
