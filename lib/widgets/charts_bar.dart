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
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  "\₹${weekSpendAmount.toStringAsFixed(0)} ",
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.60,
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
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  weekLabel,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
