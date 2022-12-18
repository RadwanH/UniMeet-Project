import 'package:flutter/material.dart';
import 'package:unimeet101/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Widget? iconPic;
  final bool isEmail;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.iconPic,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    String? validateEmail(String? value) {
      if (value != null && !value.endsWith('.edu.tr')) {
        return 'Email must end with .edu.tr';
      } else {
        return null;
      }
    }

    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );

    return isEmail
        ? Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: hintText,
                //hintText: hintText,
                border: inputBorder,
                focusedBorder: inputBorder,
                enabledBorder: inputBorder,
                filled: true,
                contentPadding: const EdgeInsets.all(8),
                prefixIcon: iconPic,
              ),
              keyboardType: textInputType,
              obscureText: isPass,
              validator: (value) => validateEmail(value),
            ),
          )
        : TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: hintText,
              //hintText: hintText,
              border: inputBorder,
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              filled: true,
              contentPadding: const EdgeInsets.all(8),
              prefixIcon: iconPic,
            ),
            keyboardType: textInputType,
            obscureText: isPass,
          );
  }
}
