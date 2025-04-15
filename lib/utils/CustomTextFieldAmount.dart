import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/AppStyles.dart';
import '../utils/CurrencyFormatText.dart';

class CustomTextFieldAmount<T> extends StatelessWidget {
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

  const CustomTextFieldAmount({
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
          style:  AppStyles.boldTextBlack,
          onTap: onTap,
          onFieldSubmitted: onChanged,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CurrencyInputFormatter(),
          ],
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
            fillColor: AppStyles.bgColor2,
            filled: true,
            hintText: hint,
            hintStyle: AppStyles.smallLabelTextBlack,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey)
            ),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey)
            ),
          ),
        ),
      );
  }
}



