import 'package:expenses/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPresed;

  AdaptativeButton({this.label, this.onPresed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return isIOSPlatform
        ? CupertinoButton(
            color: theme.primaryColor,
            child: Text(label),
            onPressed: onPresed,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : RaisedButton(
            color: theme.primaryColor,
            textColor: theme.textTheme.button.color,
            child: Text(label),
            onPressed: onPresed,
          );
  }
}
