import 'package:assignment_app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeListItem,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeListItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: ListTile(
        title: Text(
          transaction.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FittedBox(
              child: Text(
                "₹${transaction.amount.toStringAsFixed(2)}",
              ),
            ),
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(
            transaction.date,
          ),
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        // Checking for the size of window if its greater than 400 then show "delete" text
        trailing: MediaQuery.of(context).size.width > 350
            ? FlatButton.icon(
                onPressed: () => removeListItem(transaction.id),
                icon: Icon(
                  Icons.delete,
                ),
                label: Text(
                  'Delete',
                ),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => removeListItem(transaction.id),
              ),
      ),
    );
  }
}
