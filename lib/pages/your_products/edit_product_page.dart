import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/error_dialog.dart';

import '../../models/products/product.dart';
import '../../models/products/products.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  var _isLoading = false;
  var _isInitialized = false;
  var _formInput = <String, Object>{
    Product.idKey: null,
    Product.uidKey: null,
    Product.tleKey: '',
    Product.dscKey: '',
    Product.prcKey: null,
    Product.imgKey: '',
  };
  final _initialValues = {Product.prcKey: ''};
  final _formKey = GlobalKey<FormState>();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  String validateNonEmpty(String value, String label) {
    return value.isEmpty ? 'The $label must not be empty.' : null;
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final products = Provider.of<Products>(context, listen: false);
      setState(() => _isLoading = true);

      try {
        if (_formInput[Product.idKey] == null) {
          await products.add(_formInput);
        } else {
          await products.edit(_formInput);
        }
      } catch (e) {
        await showDialog<Null>(context: context, builder: buildErrorDialog);
      } finally {
        Navigator.of(context).pop();
      }
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
        _formInput = prod.toMap();
        _initialValues[Product.prcKey] = _formInput[Product.prcKey].toString();
        _imageUrlController.text = _formInput[Product.imgKey];
      }
      _initialValues[Product.tleKey] = _formInput[Product.tleKey];
      _initialValues[Product.dscKey] = _formInput[Product.dscKey];

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
        title: Text(
          _formInput[Product.idKey] == null
              ? 'Add New Product'
              : 'Edit Product',
        ),
        actions: _isLoading
            ? []
            : [
                TextButton(
                  onPressed: _saveForm,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text('SAVE'),
                ),
              ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _initialValues[Product.tleKey],
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (val) => validateNonEmpty(val, Product.tleKey),
                      onSaved: (newVal) => _formInput[Product.tleKey] = newVal,
                      onFieldSubmitted: (_) {
                        focusScope.requestFocus(_priceFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      focusNode: _priceFocusNode,
                      initialValue: _initialValues[Product.prcKey],
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
                      onSaved: (value) {
                        _formInput[Product.prcKey] = double.parse(value);
                      },
                      onFieldSubmitted: (_) {
                        focusScope.requestFocus(_descriptionFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      focusNode: _descriptionFocusNode,
                      initialValue: _initialValues[Product.dscKey],
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (val) => validateNonEmpty(val, Product.dscKey),
                      onSaved: (newVal) => _formInput[Product.dscKey] = newVal,
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
                            onSaved: (newV) =>
                                _formInput[Product.imgKey] = newV,
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
