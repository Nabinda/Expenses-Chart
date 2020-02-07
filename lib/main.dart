import './widgets/chart.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.brown,
        accentColor: Colors.green,
        fontFamily: "Acme",
        textTheme: TextTheme(
          title: TextStyle(
            fontFamily: "Acme",
            fontSize: 14,
//            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
                fontFamily: "Inconsolata",
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: ExpensesPage(),
      title: "Expenses Tracker",
    );
  }
}

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  List<Transaction> _userTransactions = [
//    Transaction(
//        itemName: "Groceries", itemPrice: 12.50, itemDate: DateTime.now()),
//    Transaction(itemName: "Food", itemPrice: 10.50, itemDate: DateTime.now()),
//    Transaction(itemName: "Car", itemPrice: 1900.50, itemDate: DateTime.now()),
  ];
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.itemDate.isAfter(DateTime.now().subtract((Duration(days: 7))));
    }).toList();
  }

  void _addNewTransaction(String txName, double txPrice, DateTime txDate) {
    final newTx =
        Transaction(itemName: txName, itemPrice: txPrice, itemDate: txDate);
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
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
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
