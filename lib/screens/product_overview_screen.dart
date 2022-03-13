import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/main_draware.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum FilterOptions { All, Favorite }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFav = false;
  var _init = false;
  var _showLoader = false;

  @override
  void didChangeDependencies() {
    if (!_init) {
      _showLoader = true;
      Provider.of<ProductsProvider>(context).getAndSetProduct().then((_) {
        setState(() {
          _showLoader = false;
        });
      });
      _init = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          Badge(
            badgeContent: Consumer<Cart>(
                builder: (ct, value, _) =>
                    Text(value.getCartCount().toString())),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              child: Icon(Icons.shopping_cart),
            ),
          ),
          PopupMenuButton(
              onSelected: (FilterOptions value) {
                setState(() {
                  if (value == FilterOptions.Favorite) {
                    _showOnlyFav = true;
                  } else {
                    _showOnlyFav = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      child: Text("All"),
                      value: FilterOptions.All,
                    ),
                    const PopupMenuItem(
                      child: Text("Favorite"),
                      value: FilterOptions.Favorite,
                    )
                  ]),
        ],
      ),
      drawer: MainDraware(),
      body: _showLoader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(_showOnlyFav),
    );
  }
}
