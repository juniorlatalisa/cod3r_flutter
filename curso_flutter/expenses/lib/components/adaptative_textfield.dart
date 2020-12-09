import 'package:expenses/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final TextInputType keyboardType;

  AdaptativeTextField({
    this.label,
    this.controller,
    this.onSubmitted,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return isIOSPlatform
        ? CupertinoTextField(
            controller: controller,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            placeholder: label,
            padding: EdgeInsets.all(20),
          )
        : TextField(
            controller: controller,
            onSubmitted: onSubmitted,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
