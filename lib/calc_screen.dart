import 'package:calculator_app/calc_button.dart';
import 'package:calculator_app/colors_manager.dart';
import 'package:flutter/material.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  String textView = "";

  void onDigitClick(String digit) {
    if (digit == "." && textView.contains(".")) return;
    textView += digit;
    setState(() {});
  }

  String savedNumber = "";
  String savedOperator = "";

  void onOperatorClick(String operator) {
    if (savedNumber.isEmpty && savedOperator.isEmpty) {
      savedNumber = textView;
      savedOperator = operator;
      textView = "";
      setState(() {});
    } else {
      String res = calculate(savedNumber, textView, savedOperator);

      savedNumber = res;
      savedOperator = operator;
      textView = "";
      setState(() {});
    }
  }

  void onEqualClicked(String _) {
    String res = calculate(savedNumber, textView, savedOperator);
    textView = res;
    savedNumber = "";
    savedOperator = "";
    setState(() {});
  }

  void onBackSpaceClicked(String _) {
    if (textView.isEmpty) return;
    textView = textView.substring(0, textView.length - 1);
    setState(() {});
  }

  void clearAll(String _) {
    textView = "";
    savedNumber = "";
    savedOperator = "";
    setState(() {
      
    });
  }

  String calculate(String lhs, String rhs, String operator) {
    double n1 = double.parse(lhs);
    double n2 = double.parse(rhs);
    double res = 0;
    if (operator == "+") {
      res = n1 + n2;
    } else if (operator == "-") {
      res = n1 - n2;
    } else if (operator == "*") {
      res = n1 * n2;
    } else if (operator == "/") {
      res = n1 / n2;
    }
    return res.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                textView,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 75,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CalcButton(
                              digit: "AC",
                              bgColor: ColorsManager.lightGray,
                              fgColor: ColorsManager.white,
                              onClick: clearAll,
                            ),
                            CalcButton(
                              digit: "X",
                              bgColor: ColorsManager.lightGray,
                              fgColor: ColorsManager.white,
                              onClick: onBackSpaceClicked,
                            ),
                            CalcButton(
                              digit: "/",
                              bgColor: ColorsManager.darkBlue,
                              fgColor: ColorsManager.white,
                              onClick: onOperatorClick,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CalcButton(digit: "7", onClick: onDigitClick),
                            CalcButton(digit: "8", onClick: onDigitClick),
                            CalcButton(digit: "9", onClick: onDigitClick),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CalcButton(digit: "4", onClick: onDigitClick),
                            CalcButton(digit: "5", onClick: onDigitClick),
                            CalcButton(digit: "6", onClick: onDigitClick),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CalcButton(digit: "1", onClick: onDigitClick),
                            CalcButton(digit: "2", onClick: onDigitClick),
                            CalcButton(digit: "3", onClick: onDigitClick),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CalcButton(
                              digit: "0",
                              flex: 4,
                              onClick: onDigitClick,
                            ),
                            CalcButton(
                              digit: ".",
                              flex: 2,
                              onClick: onDigitClick,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CalcButton(
                        digit: "*",
                        flex: 2,
                        bgColor: ColorsManager.darkBlue,
                        fgColor: ColorsManager.white,
                        onClick: onOperatorClick,
                      ),
                      CalcButton(
                        digit: "-",
                        flex: 2,
                        bgColor: ColorsManager.darkBlue,
                        fgColor: ColorsManager.white,
                        onClick: onOperatorClick,
                      ),
                      CalcButton(
                        digit: "+",
                        flex: 3,
                        bgColor: ColorsManager.darkBlue,
                        fgColor: ColorsManager.white,
                        onClick: onOperatorClick,
                      ),
                      CalcButton(
                        digit: "=",
                        flex: 3,
                        bgColor: ColorsManager.blue,
                        fgColor: ColorsManager.white,
                        onClick: onEqualClicked,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


