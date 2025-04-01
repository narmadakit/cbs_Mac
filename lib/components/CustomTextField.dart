import 'package:flutter/material.dart';
import '../utils/AppStyles.dart';

class CustomTextField<T> extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final ValueChanged onChanged;
  final String hint;
  final String? labelText;
  final TextStyle? textStyle;
  final Color borderColor;
  final double? boxHeight;
  final TextInputType textInputType;
  final Function()? onTap;

  const CustomTextField({
    super.key,
    required this.context,
    required this.controller,
    required this.onChanged,
    required this.hint,
    this.labelText,
    this.textStyle = const TextStyle(fontSize: 16),
    this.borderColor = Colors.blue,
    this.boxHeight = 40,
    required this.textInputType,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: boxHeight,
        child: TextFormField(
          keyboardType: textInputType,
          onTap: onTap,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          decoration: InputDecoration(
            fillColor: AppStyles.gridColor,
            filled: true,
            hintText: hint,
            hintStyle: AppStyles.smallLabelTextBlack,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyles.bgColor3,)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyles.bgColor3,)
            ),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyles.bgColor3,)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyles.bgColor3,)
            ),
          ),
        ),
      );
  }
}



