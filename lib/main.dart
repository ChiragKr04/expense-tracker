import 'package:assignment_app/widgets/charts.dart';
import 'package:flutter/material.dart';

import './models/transaction_model.dart';
import './widgets/new_transaction_widget.dart';
import './widgets/transaction_lists_widget.dart';

// void main() => runApp(MyApp());
void main() {
  // Hard locking landscape mode
  //--------------------------------
  // Ensuring that all the devices being run checked this condition
  // WidgetsFlutterBinding.ensureInitialized();
  // // Defining array for preferred orientation method
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
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
  final List<Transaction> _transactionList = [];

  bool _showChart = true;

  List<Transaction> get _recentTransaction {
    return _transactionList.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String name, double amount, DateTime date) {
    print(name);
    print(amount);
    final newTransactionObject = Transaction(
      DateTime.now().toString(),
      name,
      amount,
      date,
    );
    setState(() {
      _transactionList.add(newTransactionObject);
    });
  }

  void deleteListItem(String id) {
    setState(() {
      _transactionList.removeWhere((element) => element.id == id);
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
      },
    );
  }

  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    // My App BAr
    final appBar = AppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _newTransactionPopup(context),
        ),
      ],
      elevation: 100,
      title: Text("My New App"),
    );

    // My Chart Widget
    final chartWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: Charts(_recentTransaction),
    );

    // My Transaction List Widget
    final transactionListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        _transactionList,
        deleteListItem,
      ),
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newTransactionPopup(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // If we are in landscape mode we show toggle for show chart
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Show Chart"),
                      Switch(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          })
                    ],
                  ),
                // Checking value of landscape(true?) and show chart(true?) then with toggle show one at one time
                if (isLandscape)
                  _showChart ? chartWidget : transactionListWidget,
                // Checking if phone is in landscape mode (NO?) we show smaller chart with 0.3 height
                if (!isLandscape)
                  Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Charts(_recentTransaction),
                  ),
                // Checking if phone is in landscape mode (NO?) we show transaction with chart also
                if (!isLandscape) transactionListWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
