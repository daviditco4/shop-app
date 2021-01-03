import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProductPage extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

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
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  onFieldSubmitted: (_) {
                    focusScope.requestFocus(_priceFocusNode);
                  },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  focusNode: _priceFocusNode,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
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
