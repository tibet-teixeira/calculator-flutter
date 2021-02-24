import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static const operations = const ['+', '-', 'x', '/'];
  String result = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Calculadora'),
        ),
        body: Column(
          children: <Widget>[
            buildDisplay(),
            Divider(height: 0.1),
            buildKeyboard(),
          ],
        ));
  }

  Widget buildDisplay() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                result,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  decoration: TextDecoration.none,
                  fontFamily: 'Roboto',
                  fontSize: 80.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildKeyboardButton(String label,
      {int flex = 1,
      Color textColor = Colors.white,
      Color backgroundColor = Colors.black,
      Color borderColorLeft = Colors.black,
      Color borderColorTop = Colors.black}) {
    return Expanded(
      flex: flex,
      child: RaisedButton(
        color: backgroundColor,
        textColor: textColor,
        shape: Border(
          left: BorderSide(color: borderColorLeft, width: 2),
          top: BorderSide(color: borderColorTop, width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 28, fontFamily: 'Roboto'),
        ),
        onPressed: () {
          setState(() {
            if (label == 'DEL')
              result = '0';
            else if (label == '=')
              result = calculate(result);
            else if (result.length < 7)
              result = result == '0' ? label : result += label;
          });
        },
      ),
    );
  }

  String calculate(String expression) {
    int numOperations = 0;
    String operation;

    operations.forEach((item) {
      if (expression.contains(item)) {
        numOperations += 1;
        operation = item;
      }
    });

    if (numOperations > 1) return 'ERR';

    List<String> exp = expression.split(operation);
    return calculateValue(exp[0], exp[1], operation).toString();
  }

  double calculateValue(
      String operating1, String operating2, String operation) {
    double value1 = double.parse(operating1);
    double value2 = double.parse(operating2);

    switch (operation) {
      case '+':
        return value1 + value2;
      case '-':
        return value1 - value2;
      case 'x':
        return value1 * value2;
      case '/':
        return value1 / value2;
      default:
        throw new FormatException('Unknown operation');
    }
  }

  Widget buildKeyboard() {
    return Container(
      color: Colors.black,
      height: 400.0,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton('7', borderColorTop: Colors.white30),
                buildKeyboardButton('8', borderColorTop: Colors.white30),
                buildKeyboardButton('9', borderColorTop: Colors.white30),
                buildKeyboardButton('/',
                    borderColorTop: Colors.white30,
                    borderColorLeft: Colors.white30,
                    textColor: Colors.blue[300]),
                buildKeyboardButton('DEL',
                    borderColorTop: Colors.white30,
                    textColor: Colors.blue[300]),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton('4'),
                buildKeyboardButton('5'),
                buildKeyboardButton('6'),
                buildKeyboardButton('x',
                    borderColorLeft: Colors.white30,
                    textColor: Colors.blue[300]),
                buildKeyboardButton(''),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton('1'),
                buildKeyboardButton('2'),
                buildKeyboardButton('3'),
                buildKeyboardButton('-',
                    borderColorLeft: Colors.white30,
                    textColor: Colors.blue[300]),
                buildKeyboardButton(''),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKeyboardButton('.'),
                buildKeyboardButton('0'),
                buildKeyboardButton(''),
                buildKeyboardButton('+',
                    borderColorLeft: Colors.white30,
                    textColor: Colors.blue[300]),
                buildKeyboardButton('=', textColor: Colors.blue[300]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
