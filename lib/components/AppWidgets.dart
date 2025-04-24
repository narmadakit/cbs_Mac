import 'dart:developer';

import 'package:finsta_mac/view/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../Calculator/EmiCalculatorScreen.dart';
import '../Profile/ProfileScreen.dart';
import '../utils/AppStyles.dart';
import '../utils/AppText.dart';


Widget bottomNavBar({required BuildContext context, int? selectedIndex}) {
  return Container(
    // margin: const EdgeInsets.only(bottom: 5,left: 0,right: 0),
    // padding: const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.0),
            topLeft: Radius.circular(25.0),
        ),
        boxShadow:  [
          BoxShadow(color: AppStyles.shadowColor, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25.0),
          topLeft: Radius.circular(25.0),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppStyles.btnColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex??0,
          unselectedLabelStyle: const TextStyle(color: Colors.grey,fontSize: 11),
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: (value) {
            log("selectedIndex  $value $selectedIndex");
            if(selectedIndex != value){
              selectedIndex = value;
              if(selectedIndex == 0){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardScreen(
                        )));
              }
              if(selectedIndex == 1){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmiCalculatorScreen(
                        )));
              }
              if(selectedIndex == 2){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen(
                        )));
              }
            }
          },
          selectedLabelStyle: const TextStyle(color: Colors.grey,fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,size: 20,),
              label: home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined,size: 20),
              label: calculator,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined,size: 20),
              label: profile,
            ),
          ],
        ),
      )
  );
}

Widget buildGrids(String title, String icon, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 120,
      decoration: BoxDecoration(
          color:AppStyles.gridColor,
          borderRadius:AppStyles.borderRadiusCircular,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          circularBorderImage(icon),
          const SizedBox(height: 10),
          Text(title,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 13),)
        ],
      ),
    ),
  );
}


Widget circularBorderImage(String icon){
  return Container(
      decoration: BoxDecoration(borderRadius: AppStyles.imageBorderRadiusCircular,
          color: AppStyles.imageBgColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(icon,height: 20),
      ));
}

 Widget payButton(Function() onTap, String btnText, {bool disable = true}){
  return SizedBox(
    height: 50,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(25)),
            color: disable?AppStyles.btnColor:AppStyles.shadowColor),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

BoxDecoration borderContainer =BoxDecoration(
  borderRadius: AppStyles.borderRadiusCircular,
  border: Border.all(color: Colors.grey.shade400),
  // color:  Colors.transparent,
);

BoxDecoration colorButtonDecoration(Color boxColor)=>BoxDecoration(
  borderRadius: AppStyles.imageBorderRadiusCircular,
  color: boxColor
  // color:  Colors.transparent,
);
BoxDecoration borderButtonDecoration(Color borderColor)=>BoxDecoration(
    borderRadius: AppStyles.imageBorderRadiusCircular,
  border: Border.all(color: borderColor),
  color:  Colors.transparent,
);

OutlineInputBorder textFormFieldDecoration() => OutlineInputBorder(
  borderSide: BorderSide(color: AppStyles.bgColor3,),
  borderRadius: BorderRadius.circular(8)
);

showSnackBar(BuildContext context, String content, {int duration = 4}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor:Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: duration),
    ));
}

Future<String> getVersionName() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  return "version $version";
}

Widget getTextField({TextEditingController? controller, String? hintTxt, TextInputType? inputType, int? maxLength, Function? onChanged}){
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    maxLength: maxLength,
    onChanged: onChanged!(),
    decoration: InputDecoration(
      counterText: "",
      fillColor: AppStyles.gridColor,
      filled: true,
      hintText: hintTxt,
      hintStyle: AppStyles.smallLabelTextBlack,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: AppStyles.bgColor3,)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppStyles.bgColor3,)
      ),
      disabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: AppStyles.bgColor3,)
      ),
      enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: AppStyles.bgColor3,)
      ),
    ),

  );
}

Widget getRuppeText({double fontSize=14,Color color=Colors.black}){
  return Text('₹',style: GoogleFonts.acme(
  textStyle: TextStyle(
  fontWeight: FontWeight.normal,
    fontSize: fontSize,
    color: color
  )));
}
Widget getRowText({String? text, String? rupeeSymbol}){
  return Row(
    children: [
      const Text(': '),
      Text('${rupeeSymbol} ',style: GoogleFonts.acme(
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
          ))),
      Text(text??"",style: AppStyles.boldTextBlack),
    ],
  );
}

