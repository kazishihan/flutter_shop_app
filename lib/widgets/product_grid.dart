import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  bool isFavShow = false;

  ProductGrid(this.isFavShow);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ProductsProvider>(context, listen: true);
    final products = isFavShow ? dataProvider.favItem : dataProvider.items;
    // final products =  dataProvider.items;
    //final favProduct = Provider.of<ProductsProvider>(context, listen: false).favItem;
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 3 / 2),
        itemCount: products.length,
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        ),
      ),
    );
  }
}
