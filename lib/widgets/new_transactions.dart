import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;
  NewTransactions(this.addTx);
  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final itemNameController = new TextEditingController();
  final itemPriceController = new TextEditingController();
  DateTime _selectedDateTime;
  void submitData() {
    final enteredName = itemNameController.text;
    final enteredPrice = double.parse(itemPriceController.text);
    if (enteredName.isEmpty || enteredPrice < 0 || _selectedDateTime == null) {
      return;
    }
    widget.addTx(enteredName, enteredPrice, _selectedDateTime);
    Navigator.pop(context);
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        _selectedDateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Item Name",
                ),
                controller: itemNameController,
                onSubmitted: (_) {
                  submitData();
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Item Price",
                ),
                onSubmitted: (_) {
                  submitData();
                },
                controller: itemPriceController,
                keyboardType: TextInputType.number,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDateTime == null
                          ? "No Date Entered"
                          : "Picked Date: ${DateFormat.yMMMd().format(_selectedDateTime)}",
                      style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Select Purchased Date",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: _pickDate,
                  ),
                ],
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                child: Text(
                  "Add Transaction",
                ),
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
