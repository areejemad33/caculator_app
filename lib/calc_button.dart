import 'package:calculator_app/colors_manager.dart';
import 'package:flutter/material.dart';

typedef OnCalculatorButtonClick = void Function(String);

class CalcButton extends StatelessWidget {
  CalcButton({
    super.key,
    required this.digit,
    this.flex = 1,
    this.bgColor = ColorsManager.gray,
    this.fgColor = ColorsManager.blue,
    required this.onClick,
  });
  String digit;
  int flex;
  Color bgColor;
  Color fgColor;
  OnCalculatorButtonClick onClick;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {
            onClick(digit);
          },
          child: Text(
            digit,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: fgColor,
            ),
          ),
        ),
      ),
    );
  }
}
