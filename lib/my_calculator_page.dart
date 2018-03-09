import 'package:flutter/material.dart';
import 'package:flutter_calculator/item_key.dart';

class MyCalculatorPage extends StatefulWidget {
  @override
  _MyCalculatorPageState createState() => new _MyCalculatorPageState();
}

class _MyCalculatorPageState extends State<MyCalculatorPage> {
  String inputValue = '';
  String mOperator;
  String nextValue = '';
  double previousValue;
  List<List<String>> keys = [
    ['C', '( )', '%', '/'],
    ['7', '8', '9', 'x'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['+/-', '0', '.', '=']
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("Calculator"),
        backgroundColor: Colors.blue.withOpacity(0.7),
      ),
      body: new Column(
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new Container(
              padding: new EdgeInsets.only(
                  top: 12.0, left: 12.0, right: 12.0, bottom: 12.0),
              color: Colors.blue.withOpacity(0.02),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    inputValue,
                    style: new TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 50.0),
                  )
                ],
              ),
            ),
          ),
          new Expanded(
            flex: 6,
            child: new Column(
              children: keys.map((List<String> keys) {
                return getRow(keys);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRow(List<String> keys) {
    return new Expanded(
        flex: 1,
        child: new Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: keys.map((String key) {
              return new ItemKey(
                keyName: key,
                onHandleInputCallback: handleInput,
              );
            }).toList()));
  }

  void handleInput(String key) {
    if (isNumeric(key)) {
      setState(() => inputValue = inputValue + key);
      if (mOperator != null) {
        nextValue = nextValue + key;
      }
    } else {
      calculate(key);
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  void calculate(String keyValue) {
    switch (keyValue) {
      case 'C':
        mOperator = null;
        previousValue = 0.0;
        nextValue = '';
        setState(() => inputValue = '');
        break;
      case '+':
      case '-':
      case '/':
      case 'x':
        mOperator = keyValue;
        previousValue = double.parse(inputValue);
        setState(() {
          inputValue = inputValue + keyValue;
        });
        break;
      case '=':
        if (mOperator != null)
          setState(() {
            switch (mOperator) {
              case '+':
                inputValue =
                    (previousValue + double.parse(nextValue)).toString();
                break;
              case '-':
                inputValue =
                    (previousValue - double.parse(nextValue)).toString();
                break;
              case '/':
                inputValue =
                    (previousValue / double.parse(nextValue)).toString();
                break;
              case 'x':
                inputValue =
                    (previousValue * double.parse(nextValue)).toString();
                break;
            }
          });
        previousValue = double.parse(inputValue);
        nextValue = '';
        break;
    }
  }
}
