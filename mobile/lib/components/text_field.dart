import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String labelText;
  final String? message;
  final bool isPasswordTextField;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final Color borderEnabled;
  final bool isNormalField;
  final Function() onPressed;
  final bool showPassword;
  final TextInputType? keyBoardInputType;
  final List<String>? autoFill;
  final bool validateField;
  final double? fontsize;

  const MyTextField(
      {super.key,
      required this.labelText,
      this.message,
      required this.isPasswordTextField,
      this.prefixIcon,
      required this.controller,
      required this.borderEnabled,
      required this.isNormalField,
      required this.onPressed,
      required this.showPassword,
      this.keyBoardInputType,
      this.autoFill,
      required this.validateField,this.fontsize});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // fontsize
      style: TextStyle(
        fontSize: fontsize ?? 13.0, // Default to 14.0 if fontsize is null
        color: Colors.black87,
      ),
      key: key,
      controller: controller,
      autofocus: false,
      obscureText: isPasswordTextField ? showPassword : false,
      keyboardType: keyBoardInputType,
      autofillHints: autoFill,
      decoration: InputDecoration(
        prefixIcon: isNormalField ? Icon(prefixIcon) : null,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
          borderSide: const BorderSide(
            color: Colors.blueAccent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: borderEnabled,
            width: 1.0,
          ),
        ),
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        suffixIcon: isPasswordTextField
            ? IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: onPressed,
                color: Colors.grey,
              )
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (validateField) {
          if (value!.isEmpty) {
            return message;
          } else {
            return null;
          }
        }
        return null;
      },
    );
  }
}
