import 'package:flutter/material.dart';
import 'package:mobile/components/colors.dart';

import 'custom_text.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final double width;
  final double? height;
  final Function() onPressed;

  const MyButton({
    super.key,
    required this.text,
    this.textColor,
    this.buttonColor,
    required this.width,
    required this.onPressed,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 20.0,
      child: ElevatedButton(
        
        key: key,
        
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          alignment: Alignment.center,
          backgroundColor: WidgetStateProperty.all<Color>(
            buttonColor ?? light,
            
          ),
        ),
        onPressed: onPressed,
        child: CustomText(
          text: text,
          color: textColor ?? dark,
        ),
      ),
    );
  }
}
