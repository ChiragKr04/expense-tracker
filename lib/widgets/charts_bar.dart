import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartsBar extends StatelessWidget {
  final String weekLabel;
  final double weekSpendAmount;
  final double collectedSpendingAmount;

  ChartsBar(
    this.weekLabel,
    this.weekSpendAmount,
    this.collectedSpendingAmount,
  );

  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            "\₹${weekSpendAmount.toStringAsFixed(0)} ",
          ),
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: CupertinoColors.systemPink,
                ),
              ),
              FractionallySizedBox(
                heightFactor: collectedSpendingAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          weekLabel,
        ),
      ],
    );
  }
}
