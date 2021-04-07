import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/products.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen();
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final focusPreco = FocusNode();
  final focusDescricao = FocusNode();
  final focusURL = FocusNode();
  final imageURLController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, String>();
  bool _isLoading = false;

  void _loading(bool value) {
    setState(() => this._isLoading = value);
  }

  @override
  void dispose() {
    focusPreco.dispose();
    focusDescricao.dispose();
    focusURL.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    focusURL.addListener(() {
      if (_isValidImageURL(imageURLController.text)) {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final Product product = ModalRoute.of(context).settings.arguments;
      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;
        _formData['price'] = product.price.toStringAsPrecision(2);
        imageURLController.text = product.imageUrl;
      }
    }
  }

  bool _isValidImageURL(String url) {
    return url != null && url.startsWith('http');
  }

  void _saveForm() {
    if (!_form.currentState.validate()) {
      print('fail');
      return;
    }
    _form.currentState.save();
    bool novo = !_formData.containsKey('id');

    final product = Product(
      id: novo ? null : _formData['id'],
      title: _formData['title'],
      description: _formData['description'],
      price: double.parse(_formData['price']),
      imageUrl: _formData['imageUrl'],
    );
    final products = Provider.of<Products>(context, listen: false);
    if (novo) {
      _loading(true);
      products.add(product).then((value) => Navigator.of(context).pop(product));
    } else {
      products.update(product);
      Navigator.of(context).pop(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário Produto'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : () => _saveForm(),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['title'],
                      decoration: const InputDecoration(labelText: 'Título'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(focusPreco),
                      onSaved: (newValue) => _formData['title'] = newValue,
                      validator: (newValue) =>
                          (newValue == null || newValue.trim().isEmpty)
                              ? 'Informe um valor válido'
                              : null,
                    ),
                    TextFormField(
                      initialValue: _formData['price'],
                      decoration: const InputDecoration(labelText: 'Preço'),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(focusDescricao),
                      focusNode: focusPreco,
                      onSaved: (newValue) => _formData['price'] = newValue,
                      validator: (newValue) =>
                          (newValue == null || newValue.trim().isEmpty)
                              ? 'Informe um valor válido'
                              : null,
                    ),
                    TextFormField(
                      initialValue: _formData['description'],
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      onSaved: (newValue) =>
                          _formData['description'] = newValue,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: focusDescricao,
                      maxLines: 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            //Não pode ser usado devido ao 'controller'
                            //initialValue: _formData['imageUrl'],
                            decoration: const InputDecoration(labelText: 'URL'),
                            onSaved: (newValue) =>
                                _formData['imageUrl'] = newValue,
                            onFieldSubmitted: (value) => _saveForm(),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            controller: imageURLController,
                            focusNode: focusURL,
                            validator: (value) => (_isValidImageURL(value))
                                ? null
                                : 'Informe uma URL válida.',
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: imageURLController.text.isEmpty
                              ? Text('Informe a URL')
                              : SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Image.network(
                                    imageURLController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
