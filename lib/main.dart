import 'dart:io';

import 'package:flutter/cupertino.dart';

import './widgets/chart.dart';
import 'package:expenses_tracker/widgets/new_transactions.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  //-----------------------This methods turn off landscape ----------------
//  WidgetsFlutterBinding.ensureInitialized();
////  SystemChrome.setPreferredOrientations(
////      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
////    runApp(MyApp());
////  });
  runApp(MyApp());
}

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
  List<Transaction> _userTransactions = [];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.itemDate.isAfter(DateTime.now().subtract((Duration(days: 7))));
    }).toList();
  }

  void _addNewTransaction(String txName, double txPrice, DateTime txDate) {
    final newTx = Transaction(
        itemName: txName,
        itemPrice: txPrice,
        itemDate: txDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //-----------------To delete Transaction----------------------------------
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Expenses Tracker"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                  ),
                  onTap: () => _showAddTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
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
          );
    final pageBody = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart"),
                Switch.adaptive(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
          if (!isLandscape)
            Container(
                height: (MediaQuery.of(context).size.height * 0.3) -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top,
                child: Chart(_recentTransactions)),
          if (!isLandscape)
            Container(
                height: (MediaQuery.of(context).size.height * 0.7) -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top,
                child: TransactionList(_userTransactions, _deleteTransaction)),
          if (isLandscape)
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height * 0.7) -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top,
                    child: Chart(_recentTransactions))
                : Container(
                    height: (MediaQuery.of(context).size.height * 0.7) -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction)),
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
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
