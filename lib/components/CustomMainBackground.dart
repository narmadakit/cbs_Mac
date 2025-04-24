import 'package:flutter/material.dart';

import '../utils/AppStyles.dart';

class CustomMainBackground extends StatelessWidget{
  final Widget body;
  final String title;
  final String? title1;
  final Widget? bottomNavBar;
  final PreferredSizeWidget? tabBar;
  final bool? isBackButton;
  final double? toolbarHeight;
  const CustomMainBackground({super.key, required this.body, required this.title,this.bottomNavBar,this.tabBar,this.isBackButton = true,this.title1="",this.toolbarHeight = 65});
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: isBackButton!,
        elevation: 0,
        toolbarHeight: toolbarHeight,
        bottom: tabBar,
        title:  Row(
          children: [
            Text(title, style: AppStyles.customTextStyle(fontSize: 15,color: Colors.black)),
            Expanded(child: Text(title1!,overflow: TextOverflow.clip, style: AppStyles.customTextStyle(fontSize: 15,color: Colors.black),)),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar:
      Container(
          // margin: const EdgeInsets.only(bottom: 15,left: 15,right: 10),
          // padding: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(30),
            boxShadow:  [
              BoxShadow(color: AppStyles.shadowColor, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(30),
            child: bottomNavBar
          )
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppStyles.bgColor1,
              AppStyles.bgColor2,
              AppStyles.bgColor3,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(child: body),
      ),
    );
  }
}