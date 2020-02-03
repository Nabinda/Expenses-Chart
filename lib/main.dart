import 'package:expenses_tracker/widgets/new_transactions.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ExpensesPage(),
    );
  }
}

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  List<Transaction> _userTransactions = [
    Transaction(
        itemName: "Groceries", itemPrice: 12.50, itemDate: DateTime.now()),
    Transaction(itemName: "Food", itemPrice: 10.50, itemDate: DateTime.now()),
    Transaction(itemName: "Car", itemPrice: 1900.50, itemDate: DateTime.now()),
  ];
  void _addNewTransaction(String txName, double txPrice) {
    final newTx = Transaction(
        itemName: txName, itemPrice: txPrice, itemDate: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showAddTransaction(BuildContext bCtx) {
    showModalBottomSheet(
        context: bCtx,
        builder: (ctx) {
          return NewTransactions(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Tracker"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _showAddTransaction(context);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text("Chart"),
                //TODO Chart
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _showAddTransaction(context);
        },
      ),
    );
  }
}
