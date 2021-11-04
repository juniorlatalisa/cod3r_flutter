import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/grate_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  String _selectedImage = "";

  void _onSelectedImage(String selectedImage) {
    this._selectedImage = selectedImage;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _selectedImage.isEmpty) return;

    final place = Provider.of<GreatPlaces>(context, listen: false)
        .add(_titleController.text, File(_selectedImage), 0.0, 0.0);

    print(place);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Lugar'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                  ),
                  const SizedBox(width: 10),
                  ImageInput(_onSelectedImage),
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _submitForm,
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            label: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
