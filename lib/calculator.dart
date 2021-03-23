import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "0") {
          equation = "";
        }
      } else if (buttonText == "=") {
        try {
          expression = equation;
          ContextModel cm = ContextModel();
          Parser p = Parser();
          Expression exp = p.parse(expression);
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          expression=result;
          equation=result;
        } catch (e) {
          result = "ERROR";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Widget buttonText(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 1)),
          padding: EdgeInsets.all(16),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 38),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Simple Calculator"),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style: TextStyle(fontSize: 38.0),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
            Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buttonText("C", 1, Colors.redAccent),
                          buttonText("⌫", 1, Colors.blue),
                          buttonText('÷', 1, Colors.blue),
                        ],
                      ),
                      TableRow(
                        children: [
                          buttonText("7", 1, Colors.grey),
                          buttonText("8", 1, Colors.grey),
                          buttonText('9', 1, Colors.grey),
                        ],
                      ),
                      TableRow(
                        children: [
                          buttonText("4", 1, Colors.grey),
                          buttonText("5", 1, Colors.grey),
                          buttonText('6', 1, Colors.grey),
                        ],
                      ),
                      TableRow(
                        children: [
                          buttonText("1", 1, Colors.grey),
                          buttonText("2", 1, Colors.grey),
                          buttonText('3', 1, Colors.grey),
                        ],
                      ),
                      TableRow(
                        children: [
                          buttonText(".", 1, Colors.grey),
                          buttonText("0", 1, Colors.grey),
                          buttonText('00', 1, Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buttonText("*", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buttonText("+", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buttonText("-", 1, Colors.blue),
                      ]),
                      TableRow(children: [
                        buttonText("=", 2, Colors.green),
                      ])
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
