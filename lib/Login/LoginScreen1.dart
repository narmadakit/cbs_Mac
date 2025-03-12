import 'package:finsta_mac/view/DashboardScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/AppWidgets.dart';
import 'model/GetOtpModel.dart';

class LoginScreen1 extends StatefulWidget with WidgetsBindingObserver {
  const LoginScreen1({super.key});

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> with TickerProviderStateMixin {
  TextEditingController otpController = TextEditingController();
  bool showOtpScreen = false;
  int? otp;
  GetOtpModel model = GetOtpModel();
  TextEditingController mobileNumberController = TextEditingController();
  String? phone;
  bool? showPoweredLogo = false;
  String versionName = "Version No";

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
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Visibility(
                //   visible: showPoweredLogo!,
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: Image.asset(
                //       height: 50,
                //       (themeData.brightness == Brightness.light)?
                //       "images/android_12_brand.png" : "images/kapil_it_white_logo.png",
                //     ),
                //   ),
                // ),
                // const Spacer(),
                Text(
                  textAlign: TextAlign.center,
                  versionName,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ),
        body:  Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   "images/graphic_login.png",
                    //   width: 300,
                    // ),
                    Text(
                      "Login.",
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                          )),
                    ),
                    Text(
                      "Login to your account, enjoy exclusive features",
                      style: GoogleFonts.poppins(textStyle: GoogleFonts.poppins()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji)), FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],

                      controller: mobileNumberController,
                      onChanged: (value) {
                        // model.pMobileno = value;
                      },
                      // decoration: getLoginTextFieldDecoration(context, labelText: "Mobile Number"),
                      // style: getDefaultTextStyle(context),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (mobileNumberController.text == "9289026670") {
                        //   OtpResponseModel model =   OtpResponseModel();
                        //   model.otp = 123456;
                        //   GetOtpModel sendOtpModel = GetOtpModel();
                        //   sendOtpModel.pMobileno = "9289026670";
                        //   Navigator.push(context, MaterialPageRoute(builder: (builder) => OtpScreen(otpResponseModel: model)));
                        // } else {
                          if (mobileNumberController.text.length == 10) {
                          //   if (model.pMobileno != "") {
                          //     sendOtp(context);
                          //   } else {
                          //     showSnackBar(context, "Please enter mobile number to proceed");
                          //   }
                          // } else {
                          //   showSnackBar(context, "Please enter valid mobile number");
                          // }
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: themeData.primaryColorDark),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "SEND OTP",
                              style: GoogleFonts.poppins(textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: themeData.primaryColorLight)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.0,
                            color: themeData.primaryColorDark,
                          ),
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: GoogleFonts.poppins(color: themeData.primaryColorDark),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  GetOtpModel otpModel = GetOtpModel();
                                  mobileNumberController.text = "";
                                  // Navigator.push(context, MaterialPageRoute(builder: (builder) => const FetScreensFlow(verificationType: "START_LOAN_PROCESS")));
                                },
                              text: 'Sign up',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(color: Colors.green, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ), /* add child content here */
            ),
          ),
        )
      ),
    );
  }

  sendOtp(BuildContext context) async {
    dynamic value = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => const DashboardScreen(
        ),
      ),
    );
    if (value != null) {
      GetOtpModel model = value as GetOtpModel;
      otp = model.otp;
      if (otp == 0) {
        if (!mounted) return;
        showSnackBar(
          context,
          "Please try again!",
        );
      } else {
        if (!mounted) return;
        // dynamic value = await Navigator.push(context, MaterialPageRoute(builder: (builder) => OtpScreen(otpResponseModel: model)));
        if (value == null) {
          GetOtpModel otpModel = GetOtpModel();
          mobileNumberController.text = "";
        }
      }
    }
  }

}
