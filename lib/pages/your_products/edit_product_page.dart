import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../models/products/product.dart';
import '../../models/products/products.dart';
import '../../models/utils/price.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  var _isInitialized = false;
  final _formInput = {
    'id': null,
    'title': '',
    'description': '',
    'price': null,
    'imageUrl': '',
    'isWished': false,
  };
  final _initialValues = {'price': ''};
  final _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  String validateNonEmpty(String value, String label) {
    return value.isEmpty ? 'The $label must not be empty.' : null;
  }

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final products = Provider.of<Products>(context, listen: false);
      final newProduct = Product(
        id: _formInput['id'],
        title: _formInput['title'],
        description: _formInput['description'],
        price: _formInput['price'],
        imageUrl: _formInput['imageUrl'],
        isWished: _formInput['isWished'],
      );

      if (newProduct.id == null) {
        products.add(newProduct);
      } else {
        products.replace(newProduct);
      }

      Navigator.of(context).pop();
    }
  }

  void _updateImage() {
    if (!_imageUrlFocusNode.hasFocus) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final id = ModalRoute.of(context).settings.arguments as String;

      if (id != null) {
        final prod = Provider.of<Products>(context, listen: false).findById(id);
        _formInput['id'] = prod.id;
        _formInput['title'] = prod.title;
        _formInput['description'] = prod.description;
        _formInput['price'] = prod.price;
        _formInput['imageUrl'] = prod.imageUrl;
        _formInput['isWished'] = prod.isWished;
        _initialValues['price'] = _formInput['price'].toString();
        _imageUrlController.text = _formInput['imageUrl'];
      }
      _initialValues['title'] = _formInput['title'];
      _initialValues['description'] = _formInput['description'];

      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);
    const imageSize = 75.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [FlatButton(onPressed: _saveForm, child: const Text('SAVE'))],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: _initialValues['title'],
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => validateNonEmpty(value, 'title'),
                onSaved: (newVal) => _formInput['title'] = newVal,
                onFieldSubmitted: (_) {
                  focusScope.requestFocus(_priceFocusNode);
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                focusNode: _priceFocusNode,
                initialValue: _initialValues['price'],
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'The price must be a valid number.';
                  }
                  if (number <= 0.0) return 'The price must be positive.';
                  return null;
                },
                onSaved: (v) => _formInput['price'] = Price(double.parse(v)),
                onFieldSubmitted: (_) {
                  focusScope.requestFocus(_descriptionFocusNode);
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                focusNode: _descriptionFocusNode,
                initialValue: _initialValues['description'],
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) => validateNonEmpty(value, 'description'),
                onSaved: (newVal) => _formInput['description'] = newVal,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25.0, right: 15.0),
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Colors.black38,
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Icon(
                            Icons.image_outlined,
                            size: 50.0,
                            color: Colors.white,
                          )
                        : Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.contain,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      focusNode: _imageUrlFocusNode,
                      controller: _imageUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      validator: (val) {
                        return RegExp(
                          r'^(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?$',
                          caseSensitive: false,
                        ).hasMatch(val)
                            ? null
                            : 'The image URL must be valid.';
                      },
                      onSaved: (newVal) => _formInput['imageUrl'] = newVal,
                      onFieldSubmitted: (_) => _saveForm(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
