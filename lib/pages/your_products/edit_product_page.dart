import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/products/product.dart';
import '../../models/utils/price.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formInput = {
    'id': null,
    'title': '',
    'description': '',
    'price': Price(0.0),
    'imageUrl': '',
  };
  final _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  void _saveForm() {
    _formKey.currentState.save();

    final newProduct = Product(
      id: _formInput['id'],
      title: _formInput['title'],
      description: _formInput['description'],
      price: _formInput['price'],
      imageUrl: _formInput['imageUrl'],
    );

    print(newProduct.id);
    print(newProduct.title);
    print(newProduct.description);
    print(newProduct.price);
    print(newProduct.imageUrl);
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  onSaved: (newVal) => _formInput['title'] = newVal,
                  onFieldSubmitted: (_) {
                    focusScope.requestFocus(_priceFocusNode);
                  },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  focusNode: _priceFocusNode,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onSaved: (v) => _formInput['price'] = Price(double.parse(v)),
                  onFieldSubmitted: (_) {
                    focusScope.requestFocus(_descriptionFocusNode);
                  },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  focusNode: _descriptionFocusNode,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
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
                        color: Colors.black45,
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
      ),
    );
  }
}
