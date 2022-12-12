import 'package:calculator_app/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var input = "";
  var output = "";

  final List<String> buttons = [
    "DEL",
    "C",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "+/-",
    "0",
    ".",
    "=",
  ];

  bool isOperator(String x) {
    if (x == "+" || x == "-" || x == "x" || x == "÷" || x == "%" || x == "=") {
      return true;
    }
    return false;
  }

  void plusOrMinus() {
    num r = num.parse(input);

    input = (-1 * r).toString();
  }

  void equalPressed() {
    String finalInput = input;

    finalInput = finalInput.replaceAll("÷", "/");
    finalInput = finalInput.replaceAll("x", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    output = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      input ,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      output,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white, height: 10, thickness: 1),
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  //delete button
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        if (input == "") {
                          setState(() {
                            input = "0";
                          });
                        }
                        return setState(() {
                          input = input.substring(0, input.length - 1);
                          
                        });
                      },
                      buttonText: buttons[index],
                      buttonBorder: Border.all(color: Colors.red, width: 2),
                      Color: Colors.black,
                      textColor: Colors.red,
                    );
                    //clear button
                  } else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          input = "";
                          output = "";
                        });
                      },
                      buttonText: buttons[index],
                      buttonBorder: Border.all(color: Colors.green, width: 2),
                      Color: Colors.black,
                      textColor: Colors.green,
                    );
                    //Equals button
                  } else if (index == 19) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                          // input = "";
                        });
                      },
                      buttonText: buttons[index],
                      Color: Colors.green,
                      textColor: Colors.white,
                    );
                  } else if (index == 16) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          plusOrMinus();
                        });
                      },
                      buttonText: buttons[index],
                      Color: Colors.black,
                      textColor: Colors.amber,
                      buttonBorder: Border.all(color: Colors.amber, width: 2),
                    );
                  } else {
                    return MyButton(
                      buttonText: buttons[index],
                      buttonBorder: Border.all(color: Colors.amber, width: 2),
                      buttonTapped: () {
                        setState(() {
                          input += buttons[index].trim();
                        });
                      },
                      Color: isOperator(buttons[index])
                          ? Colors.amber
                          : Colors.black,
                      textColor: isOperator(buttons[index])
                          ? Colors.black
                          : Colors.amber,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
