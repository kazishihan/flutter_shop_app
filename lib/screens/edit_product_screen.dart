import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product-screen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageurlFocusNode = FocusNode();
  final _imageUrlTextControler = TextEditingController();
  final _from = GlobalKey<FormState>();
  var _edittedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');
  var _initValue = true;
  var _initialValue = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': ''
  };

  @override
  void initState() {
    _imageUrlTextControler.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlTextControler.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageurlFocusNode.dispose();
    _imageUrlTextControler.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_initValue) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        final product = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId as String);
        _edittedProduct = product;
        _initialValue = {
          'title': _edittedProduct.title!,
          'price': _edittedProduct.price.toString(),
          'description': _edittedProduct.description!,
          'imageUrl': ''
        };
        _imageUrlTextControler.text = _edittedProduct.imageUrl!;
      }
      _initValue = false;
    }

    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (_imageurlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveFrom() {
    _from.currentState?.save();
    final isValid = _from.currentState?.validate();
    if (isValid!) {
      if (_edittedProduct.id != null) {
        Provider.of<ProductsProvider>(context, listen: false)
            .updateproduct(_edittedProduct.id!, _edittedProduct);
      } else {
        Provider.of<ProductsProvider>(context, listen: false)
            .addproduct(_edittedProduct);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _from,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                initialValue: _initialValue['title'],
                onSaved: (value) {
                  _edittedProduct = Product(
                      title: value,
                      price: _edittedProduct.price,
                      imageUrl: _edittedProduct.imageUrl,
                      description: _edittedProduct.description,
                      id: _edittedProduct.id,
                      isFavorite: _edittedProduct.isFavorite);
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Please provide value';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                initialValue: _initialValue['price'],
                onSaved: (value) {
                  if (value!.isNotEmpty) {
                    _edittedProduct = Product(
                        title: _edittedProduct.title,
                        price: double.parse(value),
                        imageUrl: _edittedProduct.imageUrl,
                        description: _edittedProduct.description,
                        id: _edittedProduct.id,
                        isFavorite: _edittedProduct.isFavorite);
                  }
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Please provide value';
                  }
                  if (double.tryParse(text) == null && double.parse(text) < 1) {
                    return 'enter valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageurlFocusNode);
                },
                initialValue: _initialValue['description'],
                onSaved: (value) {
                  _edittedProduct = Product(
                      title: _edittedProduct.title,
                      price: _edittedProduct.price,
                      imageUrl: _edittedProduct.imageUrl,
                      description: value,
                      id: _edittedProduct.id,
                      isFavorite: _edittedProduct.isFavorite);
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return 'Please provide value';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageUrlTextControler.text.isEmpty
                        ? Text('Enter Url')
                        : Image.network(
                            _imageUrlTextControler.text,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image Url'),
                      textInputAction: TextInputAction.done,
                      focusNode: _imageurlFocusNode,
                      controller: _imageUrlTextControler,
                      onFieldSubmitted: (_) {
                        _saveFrom();
                      },
                      onSaved: (value) {
                        _edittedProduct = Product(
                            title: _edittedProduct.title,
                            price: _edittedProduct.price,
                            description: _edittedProduct.description,
                            imageUrl: value,
                            id: _edittedProduct.id,
                            isFavorite: _edittedProduct.isFavorite);
                      },
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Please provide value';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
