import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final Function onPress;
  AdaptiveButton({this.onPress});
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              "Select Purchased Date",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: onPress,
          )
        : FlatButton(
            child: Text(
              "Select Purchased Date",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: onPress,
          );
  }
}
