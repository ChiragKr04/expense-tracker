[1mdiff --git a/lib/main.dart b/lib/main.dart[m
[1mindex fea0fc0..54ecd8c 100644[m
[1m--- a/lib/main.dart[m
[1m+++ b/lib/main.dart[m
[36m@@ -16,7 +16,7 @@[m [mclass MyApp extends StatelessWidget {[m
     return MaterialApp([m
       debugShowCheckedModeBanner: false,[m
       theme: ThemeData([m
[31m-        primarySwatch: Colors.green,[m
[32m+[m[32m        primarySwatch: Colors.purple,[m
         accentColor: Colors.orange,[m
         fontFamily: 'gotham',[m
         //setting custom theme of text which can be used globally[m
[36m@@ -64,20 +64,26 @@[m [mclass _MyHomePageState extends State<MyHomePage> {[m
     }).toList();[m
   }[m
 [m
[31m-  void _addNewTransaction(String name, double amount) {[m
[32m+[m[32m  void _addNewTransaction(String name, double amount, DateTime date) {[m
     print(name);[m
     print(amount);[m
     final newTransactionObject = Transaction([m
       DateTime.now().toString(),[m
       name,[m
       amount,[m
[31m-      DateTime.now(),[m
[32m+[m[32m      date,[m
     );[m
     setState(() {[m
       _transactionList.add(newTransactionObject);[m
     });[m
   }[m
 [m
[32m+[m[32m  void deleteListItem(String id) {[m
[32m+[m[32m    setState(() {[m
[32m+[m[32m      _transactionList.removeWhere((element) => element.id == id);[m
[32m+[m[32m    });[m
[32m+[m[32m  }[m
[32m+[m
   void _newTransactionPopup(BuildContext context) {[m
     showModalBottomSheet([m
       context: context,[m
[36m@@ -112,12 +118,15 @@[m [mclass _MyHomePageState extends State<MyHomePage> {[m
         ),[m
       ),[m
       body: Container([m
[31m-        color: Colors.lightBlue,[m
[32m+[m[32m        color: Colors.grey[400],[m
         child: SingleChildScrollView([m
           child: Column([m
             children: [[m
               Charts(_recentTransaction),[m
[31m-              TransactionList(_transactionList),[m
[32m+[m[32m              TransactionList([m
[32m+[m[32m                _transactionList,[m
[32m+[m[32m                deleteListItem,[m
[32m+[m[32m              ),[m
             ],[m
           ),[m
         ),[m
[1mdiff --git a/lib/widgets/charts.dart b/lib/widgets/charts.dart[m
[1mindex 92a6e57..59a65bb 100644[m
[1m--- a/lib/widgets/charts.dart[m
[1m+++ b/lib/widgets/charts.dart[m
[36m@@ -6,7 +6,6 @@[m [mimport 'package:intl/intl.dart';[m
 class Charts extends StatelessWidget {[m
   final List<Transaction> recentTransaction;[m
   Charts(this.recentTransaction);[m
[31m-  double totalSum = 0.0;[m
 [m
   List<Map<String, Object>> get groupedExpense {[m
     return List.generate(7, (index) {[m
[36m@@ -28,10 +27,10 @@[m [mclass Charts extends StatelessWidget {[m
       print(totalSum);[m
 [m
       return {[m
[31m-        'day': DateFormat.E().format(weekDay).substring(0, 1),[m
[32m+[m[32m        'day': DateFormat.E().format(weekDay).substring(0, 3),[m
         'amount': totalSum,[m
       };[m
[31m-    });[m
[32m+[m[32m    }).reversed.toList();[m
   }[m
 [m
   double get maxSpending {[m
[36m@@ -55,7 +54,7 @@[m [mclass Charts extends StatelessWidget {[m
               child: ChartsBar([m
                 data['day'],[m
                 data['amount'],[m
[31m-                totalSum == 0.0[m
[32m+[m[32m                maxSpending == 0.0[m
                     ? 0.0[m
                     : (data['amount'] as double) / maxSpending,[m
               ),[m
[1mdiff --git a/lib/widgets/charts_bar.dart b/lib/widgets/charts_bar.dart[m
[1mindex adade2b..c2d9932 100644[m
[1m--- a/lib/widgets/charts_bar.dart[m
[1m+++ b/lib/widgets/charts_bar.dart[m
[36m@@ -15,24 +15,30 @@[m [mclass ChartsBar extends StatelessWidget {[m
   Widget build(BuildContext context) {[m
     return Column([m
       children: [[m
[31m-        FittedBox([m
[31m-          child: Text([m
[31m-            "\₹${weekSpendAmount.toStringAsFixed(0)} ",[m
[32m+[m[32m        Container([m
[32m+[m[32m          height: 20,[m
[32m+[m[32m          child: FittedBox([m
[32m+[m[32m            child: Text([m
[32m+[m[32m              "\₹${weekSpendAmount.toStringAsFixed(0)} ",[m
[32m+[m[32m            ),[m
           ),[m
         ),[m
         SizedBox([m
[32m+[m[32m          height: 4,[m
[32m+[m[32m        ),[m
[32m+[m[32m        Container([m
           height: 60,[m
           width: 10,[m
           child: Stack([m
[31m-            children: [[m
[32m+[m[32m            children: <Widget>[[m
               Container([m
                 decoration: BoxDecoration([m
                   border: Border.all([m
                     color: Colors.grey,[m
[31m-                    width: 1,[m
[32m+[m[32m                    width: 1.0,[m
                   ),[m
[32m+[m[32m                  color: Color.fromRGBO(220, 220, 220, 1),[m
                   borderRadius: BorderRadius.circular(10),[m
[31m-                  color: CupertinoColors.systemPink,[m
                 ),[m
               ),[m
               FractionallySizedBox([m
[36m@@ -40,6 +46,7 @@[m [mclass ChartsBar extends StatelessWidget {[m
                 child: Container([m
                   decoration: BoxDecoration([m
                     color: Theme.of(context).primaryColor,[m
[32m+[m[32m                    borderRadius: BorderRadius.circular(10),[m
                   ),[m
                 ),[m
               ),[m
[1mdiff --git a/lib/widgets/new_transaction_widget.dart b/lib/widgets/new_transaction_widget.dart[m
[1mindex 9ad4cc6..2bb41dc 100644[m
[1m--- a/lib/widgets/new_transaction_widget.dart[m
[1m+++ b/lib/widgets/new_transaction_widget.dart[m
[36m@@ -1,4 +1,5 @@[m
 import 'package:flutter/material.dart';[m
[32m+[m[32mimport 'package:intl/intl.dart';[m
 [m
 class NewTransaction extends StatefulWidget {[m
   final Function newTransaction;[m
[36m@@ -14,11 +15,14 @@[m [mclass _NewTransactionState extends State<NewTransaction> {[m
 [m
   final amountController = TextEditingController();[m
 [m
[32m+[m[32m  DateTime selectedDate;[m
[32m+[m
   void submitData() {[m
     var name = nameController.text;[m
     var amount = double.parse(amountController.text);[m
[32m+[m[32m    var date = selectedDate;[m
 [m
[31m-    if (name.isEmpty || amount <= 0) {[m
[32m+[m[32m    if (name.isEmpty || amount <= 0 || selectedDate == null) {[m
       print("Name Empty or Amount is 0");[m
       return;[m
     }[m
[36m@@ -29,11 +33,28 @@[m [mclass _NewTransactionState extends State<NewTransaction> {[m
     widget.newTransaction([m
       name,[m
       amount,[m
[32m+[m[32m      date,[m
     );[m
 [m
     Navigator.of(context).pop();[m
   }[m
 [m
[32m+[m[32m  void _pickupDate() {[m
[32m+[m[32m    showDatePicker([m
[32m+[m[32m      context: context,[m
[32m+[m[32m      initialDate: DateTime.now(),[m
[32m+[m[32m      firstDate: DateTime(2019),[m
[32m+[m[32m      lastDate: DateTime.now(),[m
[32m+[m[32m    ).then((pickedDate) {[m
[32m+[m[32m      if (pickedDate == null) {[m
[32m+[m[32m        return;[m
[32m+[m[32m      }[m
[32m+[m[32m      setState(() {[m
[32m+[m[32m        selectedDate = pickedDate;[m
[32m+[m[32m      });[m
[32m+[m[32m    });[m
[32m+[m[32m  }[m
[32m+[m
   Widget build(BuildContext context) {[m
     return Card([m
       elevation: 10,[m
[36m@@ -68,23 +89,36 @@[m [mclass _NewTransactionState extends State<NewTransaction> {[m
               // or full 'var' to use in some sense[m
               //onChanged: (val) => amountInput = val,[m
             ),[m
[32m+[m[32m            Container([m
[32m+[m[32m              height: 70,[m
[32m+[m[32m              child: Row([m
[32m+[m[32m                children: [[m
[32m+[m[32m                  Expanded([m
[32m+[m[32m                    child: Text([m
[32m+[m[32m                      selectedDate == null[m
[32m+[m[32m                          ? "No date selected!"[m
[32m+[m[32m                          : "Selected date: ${DateFormat('dd/MM/yy').format(selectedDate)}",[m
[32m+[m[32m                      style: TextStyle([m
[32m+[m[32m                        fontFamily: "gotham",[m
[32m+[m[32m                        fontSize: 17,[m
[32m+[m[32m                      ),[m
[32m+[m[32m                    ),[m
[32m+[m[32m                  ),[m
[32m+[m[32m                  FlatButton([m
[32m+[m[32m                    onPressed: _pickupDate,[m
[32m+[m[32m                    child: Text([m
[32m+[m[32m                      "Choose date",[m
[32m+[m[32m                      style: TextStyle([m
[32m+[m[32m                        color: Theme.of(context).primaryColor,[m
[32m+[m[32m                      ),[m
[32m+[m[32m                    ),[m
[32m+[m[32m                  )[m
[32m+[m[32m                ],[m
[32m+[m[32m              ),[m
[32m+[m[32m            ),[m
             Container([m
               margin: EdgeInsets.all(10),[m
               height: 40,[m
[31m-              /*decoration: BoxDecoration([m
[31m-                borderRadius: BorderRadius.all([m
[31m-                  Radius.circular(30),[m
[31m-                ),[m
[31m-                */ /*gradient: LinearGradient([m
[31m-                  begin: Alignment.bottomLeft,[m
[31m-                  end: Alignment.topRight,[m
[31m-                  colors: [[m
[31m-                    Colors.pink[700],[m
[31m-                    Colors.blueAccent,[m
[31m-                    Colors.blue[600][m
[31m-                  ],[m
[31m-                ),*/ /*[m
[31m-              ),*/[m
               child: FlatButton([m
                 shape: RoundedRectangleBorder([m
                   borderRadius: BorderRadius.circular(10),[m
[1mdiff --git a/lib/widgets/transaction_lists_widget.dart b/lib/widgets/transaction_lists_widget.dart[m
[1mindex 2564e4d..d1e6041 100644[m
[1m--- a/lib/widgets/transaction_lists_widget.dart[m
[1m+++ b/lib/widgets/transaction_lists_widget.dart[m
[36m@@ -4,14 +4,14 @@[m [mimport 'package:intl/intl.dart';[m
 [m
 class TransactionList extends StatelessWidget {[m
   final List<Transaction> transactionList;[m
[31m-[m
[31m-  TransactionList(this.transactionList);[m
[32m+[m[32m  final Function removeListItem;[m
[32m+[m[32m  TransactionList(this.transactionList, this.removeListItem);[m
 [m
   @override[m
   Widget build(BuildContext context) {[m
     return Center([m
       child: Container([m
[31m-        height: 540,[m
[32m+[m[32m        height: 400,[m
         child: transactionList.isEmpty[m
             ? Column([m
                 children: [[m
[36m@@ -46,6 +46,57 @@[m [mclass TransactionList extends StatelessWidget {[m
             : ListView.builder([m
                 itemBuilder: (ctx, index) {[m
                   return Card([m
[32m+[m[32m                    margin: EdgeInsets.symmetric([m
[32m+[m[32m                      horizontal: 10,[m
[32m+[m[32m                      vertical: 5,[m
[32m+[m[32m                    ),[m
[32m+[m[32m                    child: ListTile([m
[32m+[m[32m                      title: Text([m
[32m+[m[32m                        transactionList[index].name,[m
[32m+[m[32m                        style: Theme.of(context).textTheme.headline6,[m
[32m+[m[32m                      ),[m
[32m+[m[32m                      leading: CircleAvatar([m
[32m+[m[32m                        radius: 30,[m
[32m+[m[32m                        child: Padding([m
[32m+[m[32m                          padding: EdgeInsets.all(10),[m
[32m+[m[32m                          child: FittedBox([m
[32m+[m[32m                            child: Text([m
[32m+[m[32m                              "₹${transactionList[index].amount.toStringAsFixed(2)}",[m
[32m+[m[32m                            ),[m
[32m+[m[32m                          ),[m
[32m+[m[32m                        ),[m
[32m+[m[32m                      ),[m
[32m+[m[32m                      subtitle: Text([m
[32m+[m[32m                        DateFormat.yMMMMd().format([m
[32m+[m[32m                          transactionList[index].date,[m
[32m+[m[32m                        ),[m
[32m+[m[32m                        style: TextStyle([m
[32m+[m[32m                          color: Colors.grey[800],[m
[32m+[m[32m                        ),[m
[32m+[m[32m                      ),[m
[32m+[m[32m                      trailing: IconButton([m
[32m+[m[32m                        icon: Icon([m
[32m+[m[32m                          Icons.delete,[m
[32m+[m[32m                          color: Colors.red,[m
[32m+[m[32m                        ),[m
[32m+[m[32m                        onPressed: () =>[m
[32m+[m[32m                            removeListItem(transactionList[index].id),[m
[32m+[m[32m                      ),[m
[32m+[m[32m                    ),[m
[32m+[m[32m                  );[m
[32m+[m[32m                },[m
[32m+[m[32m                itemCount: transactionList[m
[32m+[m[32m                    .length, // give length of how long to print lists[m
[32m+[m[32m              ),[m
[32m+[m[32m      ),[m
[32m+[m[32m    );[m
[32m+[m[32m  }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32m// Card Widget of list[m
[32m+[m
[32m+[m[32m/*[m
[32m+[m[32m*  Card([m
                     margin: EdgeInsets.all(5),[m
                     elevation: 7,[m
                     color: Colors.white,[m
[36m@@ -94,12 +145,4 @@[m [mclass TransactionList extends StatelessWidget {[m
                         )[m
                       ],[m
                     ),[m
[31m-                  );[m
[31m-                },[m
[31m-                itemCount: transactionList[m
[31m-                    .length, // give length of how long to print lists[m
[31m-              ),[m
[31m-      ),[m
[31m-    );[m
[31m-  }[m
[31m-}[m
[32m+[m[32m                  );*/[m
