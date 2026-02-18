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
  String result = "";
  bool isResultShown = false;

  void onDigitClick(String digit) {
     if (isResultShown) {
    textView = "";     
    result = "";
    isResultShown = false;
  }
    if (digit == ".") {
    
      if (textView.isNotEmpty && textView[textView.length - 1] == ".") return;

    
      String lastNumber = "";
      for (int i = textView.length - 1; i >= 0; i--) {
        if ("0123456789".contains(textView[i])) {
          lastNumber = textView[i] + lastNumber;
        } else {
          break;
        }
      }
      if (lastNumber.contains(".")) return; 
    }

    textView += digit;
    setState(() {});
  }

void onOperatorClick(String operator) {
  if (textView.isEmpty && result.isEmpty) return;


  if (isResultShown) {
    textView = result;
    result = "";
    isResultShown = false;
  }


  String lastChar = textView[textView.length - 1];
  if ("+-*/".contains(lastChar)) return;

  textView += operator; 
  setState(() {});
}

void onEqualClicked(String _) {
  String exp = textView; 


  if (exp.isEmpty || "+-*/".contains(exp[exp.length - 1])) return;

  String res = evaluateInfix(exp);
  textView = res;      
  result = res;        
  isResultShown = true;
  setState(() {});
}

  int precedence(String op) {
    if (op == "+" || op == "-") return 1;
    if (op == "*" || op == "/") return 2;
    return 0;
  }

  List<String> infixToPostfix(String exp) {
    List<String> output = [];
    List<String> stack = [];

    int i = 0;

    while (i < exp.length) {
      String ch = exp[i];

      // رقم
      if ("0123456789.".contains(ch)) {
        String number = "";
        while (i < exp.length && "0123456789.".contains(exp[i])) {
          number += exp[i];
          i++;
        }
        output.add(number);
        continue;
      }

      // operator
      if ("+-*/".contains(ch)) {
        while (stack.isNotEmpty && precedence(stack.last) >= precedence(ch)) {
          output.add(stack.removeLast());
        }
        stack.add(ch);
      }

      i++;
    }

    while (stack.isNotEmpty) {
      output.add(stack.removeLast());
    }

    return output;
  }

  double evaluatePostfix(List<String> postfix) {
    List<double> stack = [];

    for (String token in postfix) {
      if ("+-*/".contains(token)) {
        double b = stack.removeLast();
        double a = stack.removeLast();

        if (token == "+") stack.add(a + b);
        if (token == "-") stack.add(a - b);
        if (token == "*") stack.add(a * b);
        if (token == "/") stack.add(a / b);
      } else {
        stack.add(double.parse(token));
      }
    }

    return stack.last;
  }

  String evaluateInfix(String exp) {
    List<String> postfix = infixToPostfix(exp);
    double result = evaluatePostfix(postfix);
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    return result.toString();
  }

  void onBackSpaceClicked(String _) {
    if (textView.isEmpty) return;
    textView = textView.substring(0, textView.length - 1);
    setState(() {});
  }

  void clearAll(String _) {
    textView = "";

    setState(() {});
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
                              digit: "Ac",
                              bgColor: ColorsManager.lightGray,
                              fgColor: ColorsManager.white,
                              onClick: clearAll,
                            ),
                            CalcButton(
                              digit: "x",
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
