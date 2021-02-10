import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final nameController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;

  void submitData() {
    var name = nameController.text;
    var amount = double.parse(amountController.text);
    var date = selectedDate;

    if (name.isEmpty || amount <= 0 || selectedDate == null) {
      print("Name Empty or Amount is 0");
      return;
    }

    print(nameController.text);
    // using 'widget.' we can access methods/variables other stuff of our StatefulWidget class
    // without 'widget.' we cant access the methods/variables inside State class
    widget.newTransaction(
      name,
      amount,
      date,
    );

    Navigator.of(context).pop();
  }

  void _pickupDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                style: TextStyle(
                  fontWeight: FontWeight.normal,
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
                  fontWeight: FontWeight.normal,
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
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? "No date selected!"
                            : "Selected date: ${DateFormat('dd/MM/yy').format(selectedDate)}",
                        style: TextStyle(
                          fontFamily: "gotham",
                          fontSize: 17,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: _pickupDate,
                      child: Text(
                        "Choose date",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 40,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Theme.of(context).accentColor,
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
      ),
    );
  }
}
