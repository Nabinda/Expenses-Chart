import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  '\$\t' + transactions[index].itemPrice.toString(),
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
                    transactions[index].itemName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    DateFormat.yMMMEd().format(transactions[index].itemDate),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              )
            ],
          ));
        },
      ),
    );
  }
}
