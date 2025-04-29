
import 'package:finsta_mac/Login/bloc/LoginBloc.dart';
import 'package:finsta_mac/Login/bloc/LoginEvent.dart';
import 'package:finsta_mac/Login/bloc/LoginState.dart';
import 'package:finsta_mac/Login/model/CompanyDetailsModel.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/utils/SharedPrefs.dart';
import 'package:finsta_mac/view/MembersScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../Home/bloc/HomeState.dart';
import '../components/AppWidgets.dart';
import '../components/CustomMainBackground.dart';
import '../network/Repository.dart';
import '../utils/AppText.dart';
import 'OtpScreen.dart';
import 'model/GetOtpModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController=TextEditingController();
  bool loadingVisibility = false;
  Repository repo=Repository();
  bool isLogin=false;
  int? otp;
  CompanyDetailsModel responseData=CompanyDetailsModel();

  @override
  void initState() {
    getLoginDetails();
    super.initState();
  }

  getLoginDetails() async {
    isLogin = await SharedPrefs.readBool(SharedPrefs.isLogin) ?? false;
    print("=======isLogin $isLogin");
    if(isLogin == true){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MembersScreen(
              )));
    }

  }
  @override
  Widget build(BuildContext context) {
    return CustomMainBackground(
        title: '',
        body:
            MultiBlocProvider(
                providers:[
                  BlocProvider<LoginBloc>(create: (context) => LoginBloc(Repository())..add(GetCompanyDetailsEvent())),
                ],
                child: BlocConsumer<LoginBloc,LoginState>(
                  builder: (BuildContext context, state) {
                    return blocBuilder(context,state);
                  },
                  listener: (context, state) {
                    return blocListener(context,state);
                  },

                ),)
    );
  }

  Widget blocBuilder(BuildContext context, LoginState state){
    print("=====state $state");
    if(state is CompanyLoadingState){
      return Center(child: CircularProgressIndicator(color: AppStyles.btnColor),);
    }
    else if(state is CompanySuccessState){
      responseData =state.data;
      SharedPrefs.saveData(SharedPrefs.companyDetails, responseData);
      // Uint8List bytesLogo = base64Decode(responseData.pPhoto);

      return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(

                children: [
                  Lottie.asset('assets/images/Login.json', width: 350, height:300),
                  // Image.memory(bytesLogo),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Login",
                          style: AppStyles.headerLargeText
                      ),
                      const Text(
                        "Login to your account, enjoy exclusive features",
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                            counterText: "",
                            fillColor: AppStyles.bgColor2,
                            filled: true,
                            hintText: 'Enter mobile number',
                            hintStyle: AppStyles.smallLabelTextBlack,
                            border: textFormFieldDecoration(),
                            focusedBorder: textFormFieldDecoration(),
                            disabledBorder:  textFormFieldDecoration(),
                            enabledBorder:  textFormFieldDecoration()
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: payButton((){
                              if(_mobileController.text == ""){
                                showSnackBar(context, 'Please enter mobile number');
                              }
                              else{
                                sendOtp(_mobileController.text);
                              }
                            }, sendOTP),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      );
    }

    else{
      return Center(child: CircularProgressIndicator(color: AppStyles.btnColor,),);
    }

  }

  sendOtp(String mobile) async {
    GetOtpModel data = await repo.getOtpRepo(mobile);
    data.mobileNumber = mobile;
    // data.bytesLogo = bytesLogo;
    if(data.pIsSaved == false){
      if (!mounted) return;
      showSnackBar(context, 'Please Enter Registered Number!');
    }
    else if(data.pIsSaved == true){
      if (!mounted) return;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                model: data,
              )));
    }
    else{
      if (!mounted) return;
      showSnackBar(context, 'Something went wrong, try again later!');
    }
   // print("respose-----${data.pIsSaved}");
  }

  void blocListener(BuildContext context, state){
    if(state is HomeLoadingState ){
      loadingVisibility=true;
    }else if(state is HomeSuccessState){

    }
  }
  
}
