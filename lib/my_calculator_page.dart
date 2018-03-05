import 'package:flutter/material.dart';


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
                  top: 12.0,
                  left: 12.0,
                  right: 12.0,
                  bottom: 12.0),
              color: Colors.blue.withOpacity(0.02),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(inputValue,
                    maxLines: 1,
                    style: new TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 50.0),)
                ],
              ),
            ),
          ),
          new Expanded(
            flex: 6,
            child: new Container(
              color: Colors.white,
              child: new Column(
                children: keys.map((List<String> keys) {
                  return getRow(keys);
                }).toList(),
              ),
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
              return new Expanded(flex: 1,
                  child: new Container(
                    decoration: new BoxDecoration(
                      border: new Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 0.5,
                          style: BorderStyle.solid
                      ),
                    ),
                    child:  new FlatButton(
                      color: key=='='?Colors.blue.withOpacity(0.7) : Colors.white,
                      child: new Text(key,
                        style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 35.0,
                          color: getTextColor(key),
                          fontStyle: FontStyle.normal,),),
                      onPressed: () {
                        handleInput(key);
                      }
                      ,),
                  ));
            }).toList()));

  }

  Color getTextColor(String key){
    switch(key){
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
