import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

 themeNotifier(String memberId) => ValueNotifier<String>(memberId);
var dateOutputFormat = DateFormat('yyyy-MM-dd');
var dateNow = dateOutputFormat.format(DateTime.now());
// var dateNowFormat = '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}';


removeCurrencyFormat(dynamic amount) {
 // Remove commas and .0 if they exist
 return double.parse(amount.toString().replaceAll(',', '').replaceAll('.00', ''));
}

final currencyFormat = NumberFormat.simpleCurrency(locale: "HI", decimalDigits: 2, name: "");

convertToCurrencyFormat(dynamic amount) {
 amount = removeCurrencyFormat(amount);
 return currencyFormat.format(amount);
}

convertToCurrencyFormat2(dynamic amount) {
 amount = removeCurrencyFormat(amount);
 double parsedAmount = double.tryParse(amount.toString()) ?? 0.0;
 dynamic amt = parsedAmount.toStringAsFixed(0);
 return amt;
}

String convertDateFormat(String input){
 String dateTimeString = input;
 DateTime parsedDateTime = DateTime.parse(dateTimeString);

 // Format the DateTime object in a custom format
 return DateFormat('dd-MM-yyyy').format(parsedDateTime);
}
String convertDateFormatDisplay(String input){
 String dateTimeString = input;
 DateTime parsedDateTime = DateTime.parse(dateTimeString);
 String formattedDate = DateFormat('dd MMM yyyy').format(parsedDateTime);
 // Format the DateTime object in a custom format
 return formattedDate;
}

String getTenureModeName(String text, String paymentMode) {
 String dummy = "";
 if (paymentMode == "Monthly") {
  if (int.parse(text) > 1) {
   dummy = "$text months";
  } else {
   dummy = "$text month";
  }
 }
 if (paymentMode == "Daily") {
  if (int.parse(text) > 1) {
   dummy = "($text days)";
  } else {
   dummy = "($text day)";
  }
 }
 if (paymentMode == "Yearly") {
  if (int.parse(text) > 1) {
   dummy = "($text years)";
  } else {
   dummy = "($text year)";
  }
 }
 if (paymentMode == "Quarterly") {
  if (int.parse(text) > 1) {
   dummy = "($text Quarter)";
  } else {
   dummy = "($text Quarters)";
  }
 }
 if (paymentMode == "Fortnightly") {
  if (int.parse(text) > 1) {
   dummy = "($text Fortnights)";
  } else {
   dummy = "($text Fortnight)";
  }
 }
 if (paymentMode == "Half-Yearly") {
  if (int.parse(text) > 1) {
   dummy = "($text Half-Years)";
  } else {
   dummy = "($text Half-Year)";
  }
 }
 if (paymentMode == "Weekly") {
  if (int.parse(text) > 1) {
   dummy = "($text week)";
  } else {
   dummy = "($text weeks)";
  }
 }
 if (paymentMode == "Weekly") {
  if (int.parse(text) > 1) {
   dummy = "($text week)";
  } else {
   dummy = "($text weeks)";
  }
 }
 if (paymentMode == "Bi-Weekly") {
  if (int.parse(text) > 1) {
   dummy = "($text Bi-week)";
  } else {
   dummy = "($text Bi-weeks)";
  }
 }
 return dummy;
}

getNumericOnly(String text){
 String input = text;
 String numberOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
 print(numberOnly); // Output: 12
}

double parseLocalizedNumber(String input) {
 return double.parse(input.replaceAll(',', ''));
}

double? removeCommasFromNumber(value){
 String cleaned = value.replaceAll(',', '');
 double? number = double.tryParse(cleaned);
 if (number != null) {
 return number;// Output: 855522.0
 } else {
 return 0;// This won't happen here
 }
}


