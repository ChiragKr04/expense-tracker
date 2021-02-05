import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final nameController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    var name = nameController.text;
    var amount = double.parse(amountController.text);

    if (name.isEmpty || amount <= 0) {
      print("Name Empty or Amount is 0");
      return;
    }

    print(nameController.text);
    widget.newTransaction(
      name,
      amount,
    );
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              style: TextStyle(
                fontSize: 17,
              ),
              decoration: InputDecoration(
                labelText: "Name",
              ),
              controller: nameController,
              //onChanged: (val) => nameInput = val,
            ),
            TextField(
              style: TextStyle(
                fontSize: 17,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              controller: amountController,
              onSubmitted: (_) => submitData(),
              // on submit gives string we can use '_' to get value but dont require it
              // or full 'var' to use in some sense
              //onChanged: (val) => amountInput = val,
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.pink[700],
                    Colors.blueAccent,
                    Colors.blue[600]
                  ],
                ),
              ),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.transparent,
                onPressed: () => submitData(),
                child: Text(
                  "Add new Expense",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
