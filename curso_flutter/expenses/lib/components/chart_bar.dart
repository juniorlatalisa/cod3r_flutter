import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentege;
  final double height;

  ChartBar(this.label, this.value, this.percentege, this.height);

  @override
  Widget build(BuildContext context) {
    final _textHeight = 20.0;
    final _spaceHeight = height * 0.03;
    final _paddingHeight = 60.0;
    return Column(
      children: <Widget>[
        Container(
          height: _textHeight,
          child: FittedBox(
            child: Text('${value.toStringAsFixed(2)}'),
          ),
        ),
        SizedBox(height: _spaceHeight),
        Container(
          height: height - _paddingHeight - _textHeight * 2 - _spaceHeight * 2,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentege,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: _spaceHeight),
        Container(
          height: _textHeight,
          child: Text(label),
        )
      ],
    );
  }
}
