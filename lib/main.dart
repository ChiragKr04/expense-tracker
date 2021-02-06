import 'package:flutter/material.dart';

import './models/transaction_model.dart';
import './widgets/new_transaction_widget.dart';
import './widgets/transaction_lists_widget.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.orange,
        fontFamily: 'gotham',
        //setting custom theme of text which can be used globally
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                fontFamily: "gotham",
                fontWeight: FontWeight.bold,
              ),
            ),
        //setting custom theme of appbar which can be used globally
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'sfpro',
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.white,
                ),
              ),
        ),
      ),
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
  //String nameInput;
  //String amountInput;
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var amountController = TextEditingController();

  var nameController = TextEditingController();

  final List<Transaction> _transactionList = [];

  void _addNewTransaction(String name, double amount) {
    print(name);
    print(amount);
    final newTransactionObject = Transaction(
      DateTime.now().toString(),
      name,
      amount,
      DateTime.now(),
    );
    setState(() {
      _transactionList.add(newTransactionObject);
    });
  }

  void _newTransactionPopup(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () => {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _newTransactionPopup(context),
          ),
        ],
        elevation: 100,
        title: Text("My New App"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newTransactionPopup(context),
        child: Icon(
          Icons.add,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.green[700],
              Colors.deepPurple,
              Colors.pink,
              Colors.redAccent,
              Colors.orange[700],
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TransactionList(_transactionList),
            ],
          ),
        ),
      ),
    );
  }
}
