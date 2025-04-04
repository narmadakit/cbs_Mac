import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles{
 static Color btnColor = const Color(0xff400e43);
 static Color cardColor = const Color(0xff645394);
 static Color bgColor1 = const Color(0xffe7d3f4);
 static Color bgColor2 = const Color(0xfffce4c5);
 static Color bgColor3 = const Color(0xffdabcb3);
 static Color carouselCardColor = const Color(0xffb3aed7).withOpacity(0.7);
 static Color coloredText = const Color(0xffb3aed7);
 static Color gridColor =  const Color(0xffffffff);
 static Color imageBgColor =  const Color(0xffe1d0f6);
 static Color bottomNavBarColor =  const Color(0xffebcfb9);
 static Color shadowColor =  const Color(0xffd4b6ae);
 static Color colorGreen = const Color(0xFF35c371);
 static Color colorOrange =  Colors.deepOrange;
 static Color lightGreenColor = Color(0xFFd5ffcf);

 static TextStyle smallLabelText=const TextStyle(fontSize: 13,color: Colors.white);
 static TextStyle headerLargeText= GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 40);
 static TextStyle headerMediumText= GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22);
 static TextStyle customTextStyle({double? fontSize, Color? color}) => GoogleFonts.poppins(color: color, fontWeight: FontWeight.w600, fontSize: fontSize);
 static TextStyle statusTextStyle({double? fontSize}) => GoogleFonts.poppins(color: Colors.amber.shade900, fontWeight: FontWeight.w600, fontSize: fontSize);
 static TextStyle smallLabelTextBlack=const TextStyle(fontSize: 11,color: Colors.black);
 static TextStyle smallLabelTextBold=const TextStyle(fontSize: 11,color: Colors.black,fontWeight: FontWeight.w600);
 static TextStyle headerTextBlack=const TextStyle(color: Colors.black,fontWeight: FontWeight.bold);
 static TextStyle highLightText= TextStyle(color: AppStyles.btnColor,fontWeight: FontWeight.bold,fontSize: 13);
 static TextStyle boldTextBlack= TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12);
 static TextStyle headerTextWhite=const TextStyle(color: Colors.white,fontWeight: FontWeight.bold);
 static BorderRadius borderRadiusCircular=const BorderRadius.all(Radius.circular(12));
 static BorderRadius borderRadiusCircularColor=const BorderRadius.all(Radius.circular(8));
 static BorderRadius imageBorderRadiusCircular=const BorderRadius.all(Radius.circular(25));
}