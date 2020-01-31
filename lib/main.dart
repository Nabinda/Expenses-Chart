import 'package:expenses_tracker/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Expenses Tracker"),
          centerTitle: true,
        ),
        body: ExpensesPage(),
      ),
    );
  }
}

class ExpensesPage extends StatefulWidget {
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  List<Transaction> transaction = [
    Transaction(
        itemName: "Groceries", itemPrice: 12.50, itemDate: DateTime.now()),
    Transaction(itemName: "Food", itemPrice: 10.50, itemDate: DateTime.now()),
    Transaction(itemName: "Car", itemPrice: 1900.50, itemDate: DateTime.now()),
  ];
  String itemName;
  String itemPrice;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Card(
            child: Text("Chart"),
            //TODO Chart
            elevation: 5,
          ),
        ),
        Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: "Item Name",
                  ),
                  onChanged: (value) {
                    itemName = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Item Price",
                  ),
                  onChanged: (val) {
                    itemPrice = val;
                  },
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.grey,
                  child: Text(
                    "Add Transaction",
                  ),
                  onPressed: () {
                    setState(() {
                      transaction.add(Transaction(
                          itemPrice: double.parse(itemPrice),
                          itemName: itemName,
                          itemDate: DateTime.now()));
                    });
                  },
                )
              ],
            ),
          ),
        ),
        Column(
          children: transaction.map((tx) {
            return Card(
                child: Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '\$\t' + tx.itemPrice.toString(),
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  padding: EdgeInsets.all(5.0),
                ),
                //Food Item & Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tx.itemName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      DateFormat.yMMMEd().format(tx.itemDate),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                )
              ],
            ));
          }).toList(),
        ),
      ],
    );
  }
}
