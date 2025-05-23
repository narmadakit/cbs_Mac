
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:finsta_mac/Home/model/MemberDetailsResponse.dart';
import 'package:finsta_mac/Login/LoginScreen.dart';
import 'package:finsta_mac/components/CustomDropdown.dart';
import 'package:finsta_mac/components/CustomMainBackground.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/utils/SharedPrefs.dart';
import 'package:finsta_mac/view/MembersScreen.dart';
import 'package:flutter/material.dart';
import '../components/AppWidgets.dart';
import '../components/KeyValueModel.dart';
import '../utils/AppText.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MemberDetailsResponse responseData = MemberDetailsResponse();
  String memberId="";

  getMemberDetails() async {
  var data = await SharedPrefs.readData(SharedPrefs.memberDetails);
  responseData=MemberDetailsResponse.fromJson(data);
  memberId = responseData.pmemberid.toString();
  log("===pContactName ${responseData.pContactName} ");
  setState(() {});
  }

  @override
  void initState() {
    getMemberDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMainBackground(
        title: profile,
        isBackButton: false,
        bottomNavBar: bottomNavBar(
          context: context,
          selectedIndex: 2,
        ),
        body:buildBody(context)
    );
  }

  Widget buildBody(BuildContext context) {
    return ListView(children: [buildCaruselCard(context)]);
  }

  Widget buildCaruselCard(BuildContext context) {
    double gapHeight=15.0;
    double rowWidth=0.0;
    int flex=2;
    Uint8List? bytesLogo;
    if (responseData.pImage != null && responseData.pImage!.isNotEmpty) {
       bytesLogo = base64Decode(responseData.pImage??"");
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration:  borderContainer,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (responseData.pImage != null)?
              ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.memory(bytesLogo!,height: 70,width: 70,fit: BoxFit.fill,))
              :Image.asset("assets/images/profile.png",height: 70,),

              SizedBox(height: gapHeight,),
              SizedBox(height: gapHeight,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(responseData.pContactName.toString() ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black,letterSpacing: 3, fontWeight: FontWeight.bold),)),

                ],
              ),

              SizedBox(height: gapHeight,),
              SizedBox(height: gapHeight,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:flex,
                            child: Text('Branch :',style: AppStyles.smallLabelTextBlack,)),
                        // SizedBox(width: rowWidth),
                        Expanded(
                            flex: flex,
                            child: getRowText(
                              text: responseData.pbranchname??"",
                              rupeeSymbol: ""
                            ))
                      ],
                    ),
                    SizedBox(height: gapHeight,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: flex,
                            child: Text('Member Code:',style: AppStyles.smallLabelTextBlack,)),
                        Expanded(
                            flex: flex,
                            child: getRowText(
                                text: responseData.pmembercode??"",
                                rupeeSymbol: ""
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5,),
          // CustomDropdown(context: context,selectedValue: _selectedValue,
          //   onChanged: (value) {
          //   setState(() {
          //     _selectedValue = value;
          //   });
          //   Navigator.pop(context);
          //   },
          //   hint: "",items: listDataKyValue,icon: Icons.arrow_downward,labelText: '', ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           flex: flex,
              //           child: const Text('Select Member')),
              //       const SizedBox(width: 10,),
              //       Expanded(
              //         flex: flex,
              //         child: Container(
              //           height: 42,
              //           decoration: BoxDecoration(
              //             borderRadius: const BorderRadius.all(Radius.circular(4)),
              //             border: Border.all(color: AppStyles.bgColor3),
              //           ),
              //           child: DropdownButton(
              //             dropdownColor: AppStyles.gridColor,
              //             underline: Container(),
              //             hint: _selectedValue == ""
              //                 ? Text('Select', style: AppStyles.smallLabelTextBlack)
              //                 : Text(
              //               _selectedValue,
              //               style: AppStyles.headerTextBlack,
              //             ),
              //             isExpanded: true,
              //             iconSize: 30.0,
              //             padding: const EdgeInsets.only(left: 10),
              //             style: AppStyles.headerTextBlack,
              //             items: listData.map(
              //                   (val) {
              //                 return DropdownMenuItem(
              //                   value: val.pmemberid.toString(),
              //                   child: Text(val.pmemberid.toString()),
              //                 );
              //               },
              //             ).toList(),
              //             onChanged: (val) {
              //               setState(
              //                     () {
              //                   _selectedValue = val.toString();
              //                  SharedPrefs.saveString(SharedPrefs.memberId,_selectedValue);
              //                   getMemberDetails();
              //                 },
              //               );
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: gapHeight,),
              SizedBox(height: gapHeight,),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MembersScreen(
                          )));
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppStyles.shadowColor)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                      child: Text('Switch Member',style: AppStyles.boldTextBlack,),
                    )),
              ),
              const SizedBox(height: 90,),
              GestureDetector(
                  onTap: () {
                    logoutAlert(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.power_settings_new_outlined,color: AppStyles.colorOrange),
                        Text('  Logout',style: AppStyles.headerTextBlack),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

   logoutAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              alignment: Alignment.center,
              backgroundColor: AppStyles.gridColor,
                shape: const RoundedRectangleBorder(
                // side: BorderSide(color: Colors.white, width: 0.4),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              // elevation: 5,
              insetPadding: const EdgeInsets.all(2.0),
              title: Text(
                'Are you sure you want to logout?',
                style:  AppStyles.customTextStyle(fontSize: 16),
              ),
              actions: [
                InkWell(
                  onTap: () async {
                    if (!mounted) return;
                    bool loggedOut = await SharedPrefs.clearPreferences();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text('Yes', style: AppStyles.customTextStyle(fontSize: 16,color: AppStyles.colorGreen)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(' No ', style: AppStyles.statusTextStyle(fontSize: 15)),
                    )
                ),
              ],
            ),
          );
        }).then((exit) {
      if (exit == null) return;
      if (exit) {
        // user pressed Yes button
      } else {
        // user pressed No button
      }
    });
  }


}


