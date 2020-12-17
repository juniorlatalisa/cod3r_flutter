import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentege;

  /* 
  O construtor ser const, quando possivel, ajuda a otimização em tempo de compilação 
  */
  const ChartBar(this.label, this.value, this.percentege);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final textHeight = 18.0 * MediaQuery.of(context).textScaleFactor;
      final spaceHeight = constraints.maxHeight * 0.05;
      return Column(
        children: <Widget>[
          Container(
            height: textHeight,
            child: FittedBox(
              child: Text('${value.toStringAsFixed(2)}'),
            ),
          ),
          SizedBox(height: spaceHeight),
          Container(
            height:
                constraints.maxHeight - (textHeight * 2) - (spaceHeight * 2),
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
                    color: const Color.fromRGBO(220, 220, 220, 1),
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
          SizedBox(height: spaceHeight),
          Container(
            height: textHeight,
            child: FittedBox(child: Text(label)),
          )
        ],
      );
    });
  }
}
