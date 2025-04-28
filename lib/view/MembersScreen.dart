
import 'dart:convert';
import 'dart:developer';
import 'package:finsta_mac/Login/LoginScreen.dart';
import 'package:finsta_mac/Login/model/CompanyDetailsModel.dart';
import 'package:finsta_mac/components/CustomMainBackground.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/utils/SharedPrefs.dart';
import 'package:finsta_mac/view/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Home/model/MemberDetailsResponse.dart';
import '../Profile/bloc/ProfileBloc.dart';
import '../Profile/bloc/ProfileEvent.dart';
import '../Profile/bloc/ProfileState.dart';
import '../components/AppWidgets.dart';
import '../network/Repository.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  static const String TAG = "MemberScreen";
  final List<String> items = List.generate(20, (index) => 'Item $index');  // Example dynamic data
  String mobileNo="";
  bool loadingVisibility =true;
  List<MemberDetailsResponse> listResponnseData=[];
  List<CompanyDetailsModel> companyResponseData=[];
  String versionName = "Version NO";

  @override
  void initState() {
    getVersionName().then((value) {
      setState(() {
        versionName = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double gapHeight=12.0;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if(Navigator.of(context).canPop()){
          SystemNavigator.pop();
        }
      },
      child: CustomMainBackground(
          title: '',
          // toolbarHeight: 40,
          isBackButton: false,
          body:
        MultiBlocProvider(
          providers: [
            BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(Repository())..add(ProfileInitEvent()))
          ],
          child: BlocConsumer<ProfileBloc,ProfileState>(
            listener: (context,state){
              if(state is ProfileLoadingState){
                loadingVisibility = true;
              }
              else if(state is ProfileSuccessState){
                listResponnseData =state.responseData;
                loadingVisibility = false;
              }
            },
            builder: (context, state) {
              if(state is ProfileLoadingState){
                return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
              }
              else if(state is ProfileSuccessState){
                listResponnseData =state.responseData;
                return buildBody(context,state);
              }
             else{
                return Center(child: CircularProgressIndicator(color: AppStyles.btnColor));
              }
            },
          ),
        )
      ),
    );
  }

  Widget buildBody(BuildContext context, ProfileState state) {
    double gapHeight=MediaQuery.of(context).size.height * 0.03;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
         Expanded(
           child: Column(
             children: [
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: AppStyles.gridColor,
                 ),
           
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ClipRRect(
                       borderRadius: BorderRadius.circular(60),
                       child: Image.asset('assets/images/app_icon.png', height: 95.0)),
                 ),
               ),
               SizedBox(height: gapHeight),
               Text('Select Member',style: AppStyles.headerTextBlack),
               SizedBox(height: gapHeight),
               GridView.builder(
                 shrinkWrap: true,
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,  // Number of columns
                   crossAxisSpacing: 3,  // Space between columns
                   mainAxisSpacing: 2,   // Space between rows
                 ),
                 itemCount: listResponnseData.length,
                 itemBuilder: (context, index) {
                   MemberDetailsResponse listData=listResponnseData[index];
                   return buildCaruselCard(context,listData);
                 },
               ),
             ],
           ),
         ),
          Column(
            children: [
              GestureDetector(
                  onTap: () => logoutAlert(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.power_settings_new_outlined,color: AppStyles.colorOrange),
                        Text(' Logout',style: AppStyles.headerTextBlack),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("V $versionName",style: const TextStyle(color: Colors.black54),),
              ),
            ],
          )
        ],
      ),
    );

  }

  Widget buildCaruselCard(BuildContext context, MemberDetailsResponse listData) {
    double gapHeight=12.0;
    double rowWidth=0.0;
    int flex=2;
    Uint8List? bytesLogo;
    if (listData.pImage != null && listData.pImage!.isNotEmpty) {
       bytesLogo = base64Decode(listData.pImage);
    }

    return GestureDetector(
      onTap: () {
        SharedPrefs.saveData(SharedPrefs.memberDetails, listData);
        SharedPrefs.saveString(SharedPrefs.memberId,listData.pmemberid.toString());
        SharedPrefs.saveString(SharedPrefs.memberName,listData.pContactName.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration:  borderContainer,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (listData.pImage != null)?
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.memory(bytesLogo!,height: 60,width: 60,fit: BoxFit.fill,))
               : Image.asset("assets/images/profile.png",height: 50),
                SizedBox(height: gapHeight,),
                Text(listData.pmembercode??"" ,
                  textAlign: TextAlign.center,
                  style: AppStyles.customTextStyle(fontSize: 12,color: AppStyles.btnColor)),
                Text( listData.pContactName??"",
                  textAlign: TextAlign.center,
                  style: AppStyles.smallLabelTextBlack),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void logoutAlert(BuildContext context) {
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
                style: AppStyles.customTextStyle(fontSize: 16),
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
