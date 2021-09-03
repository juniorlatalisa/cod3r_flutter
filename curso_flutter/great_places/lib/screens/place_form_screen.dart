import 'package:flutter/material.dart';
import 'package:great_places/widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();

  void _submitForm() {
    print(this);
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
                  ImageInput(),
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
