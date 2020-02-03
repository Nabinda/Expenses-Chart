import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;
  NewTransactions(this.addTx);
  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final itemNameController = new TextEditingController();
  final itemPriceController = new TextEditingController();
  void submitData() {
    final enteredName = itemNameController.text;
    final enteredPrice = double.parse(itemPriceController.text);
    if (enteredName.isEmpty || enteredPrice < 0) {
      return;
    }
    widget.addTx(enteredName, enteredPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              controller: itemNameController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Item Price",
              ),
              controller: itemPriceController,
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.grey,
              child: Text(
                "Add Transaction",
              ),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
