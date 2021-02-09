import 'package:assignment_app/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function removeListItem;
  TransactionList(this.transactionList, this.removeListItem);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        child: transactionList.isEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "No added expenses found ",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Add one now by pressing '+'",
                      style: TextStyle(
                        fontFamily: "gotham",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      title: Text(
                        transactionList[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              "₹${transactionList[index].amount.toStringAsFixed(2)}",
                            ),
                          ),
                        ),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMd().format(
                          transactionList[index].date,
                        ),
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () =>
                            removeListItem(transactionList[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transactionList
                    .length, // give length of how long to print lists
              ),
      ),
    );
  }
}

// Card Widget of list

/*
*  Card(
                    margin: EdgeInsets.all(5),
                    elevation: 7,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 1,
                            ),
                          ),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "₹${transactionList[index].amount.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(3),
                              child: Text(
                                transactionList[index].name,
                                // setting theme of subtitle from main.dart
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(3),
                              child: Text(
                                DateFormat.yMMMMd()
                                    .format(transactionList[index].date),
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );*/
