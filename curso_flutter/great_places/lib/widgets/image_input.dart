import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 180,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: const Text('Nenhuma imagem.'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: const Text('Tirar foto'),
            onPressed: () => print(this),
          ),
        ),
      ],
    );
  }
}
