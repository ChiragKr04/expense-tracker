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
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              "\₹${weekSpendAmount.toStringAsFixed(0)} ",
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: collectedSpendingAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
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
