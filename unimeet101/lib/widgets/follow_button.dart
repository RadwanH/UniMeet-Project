import 'package:flutter/material.dart';
import 'package:unimeet101/utils/global_variables.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;

  const FollowButton(
      {super.key,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.textColor,
      this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).size.width <= webScreenSize
          ? const EdgeInsets.only(top: 2)
          : const EdgeInsets.only(top: 10),
      child: TextButton(
        onPressed: function,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width <= webScreenSize ? 250 : 350,
          height: MediaQuery.of(context).size.width <= webScreenSize ? 27 : 37,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
