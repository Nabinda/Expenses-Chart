import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraint) {
              return Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "NO TRANSAACTION YET!!!",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  Container(
                    height: constraint.maxHeight * 0.70,
                    child: Image.asset(
                      "assets/images/box.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FittedBox(
                        child: Text(
                          '\$\t' + transactions[index].itemPrice.toString(),
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].itemName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMEd().format(transactions[index].itemDate),
                    style: Theme.of(context).textTheme.title,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red[900],
                    onPressed: () {
                      deleteTx(transactions[index].id);
                    },
                  ),
                ),
              );
            },
          );
  }
}
