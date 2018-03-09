import 'package:flutter/material.dart';

typedef OnHandleInputCallback(String key);

class ItemKey extends StatelessWidget {
  ItemKey({this.keyName, this.onHandleInputCallback});

  final String keyName;
  final OnHandleInputCallback onHandleInputCallback;

  _getBackgroundColor() {
    if (keyName == '=')
      return Colors.blue.withOpacity(0.7);
    else
      return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        flex: 1,
        child: new FlatButton(
            shape: new Border.all(
                color: Colors.grey.withOpacity(0.1),
                width: 0.5,
                style: BorderStyle.solid),
            color: _getBackgroundColor(),
            child: new Text(
              keyName,
              style: new TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 35.0,
                color: _getTextColor(keyName),
                fontStyle: FontStyle.normal,
              ),
            ),
            onPressed: () {
              onHandleInputCallback(keyName);
            }));
  }

  _getTextColor(String key) {
    switch (key) {
      case 'C':
        return Colors.red;
      case '( )':
      case '%':
      case '/':
      case 'x':
      case '-':
      case '+':
        return Colors.blue;
      case '=':
        return Colors.white;
      default:
        return Colors.black54;
    }
  }
}
