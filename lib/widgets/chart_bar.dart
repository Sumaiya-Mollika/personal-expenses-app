import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String? label;
  final double? spendAmount;
  final double? totalSependPercent;
  ChartBar({this.label, this.spendAmount, this.totalSependPercent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child:
                FittedBox(child: Text('${spendAmount!.toStringAsFixed(0)}'))),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 70,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade800, width: 1),
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: totalSependPercent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          ]),
        ),
        SizedBox(
          height: 5,
        ),
        Text(label!),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
