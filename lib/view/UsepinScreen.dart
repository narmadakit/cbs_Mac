import 'dart:async';
import 'package:finsta_mac/utils/SharedPrefs.dart';
import 'package:finsta_mac/view/DashboardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Login/LoginScreen.dart';


class UsePinScreen extends StatefulWidget {
  final String? authorized;

  const UsePinScreen({
    super.key,
    this.authorized,
  });


  @override
  State<UsePinScreen> createState() => _UsePinScreenState();
}


class _UsePinScreenState extends State<UsePinScreen> {
  TextEditingController OTPController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  var sharedpref = SharedPrefs();
  var pin;
  BuildContext? buildContext;
  bool isBiometricVisible = false;

  @override
  void initState() {
    // errorController = StreamController<ErrorAnimationType>();
    getLoginData();
    super.initState();
  }

  // @override
  // void dispose() {
  //   errorController!.close();
  //   super.dispose();
  // }


  getLoginData() async {
    // pin = await SharedPreferencesUtils.getPin();
    if (pin != null) {

    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const DashboardScreen(
              )));
    }
  }


  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double gapHeight = size.height * 0.025;
    ThemeData themeData = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child:
                    // Lottie.asset("assets/lotties/spark.json",height:  size.height / 4)
                    Image.asset('assets/images/app_icon.png', height: size.height / 6)),
              ),
            ),
            SizedBox(height: gapHeight),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ENTER PIN',),
                  const SizedBox(height: 5),
                  const Text(
                    'Use your 4 digit PIN to continue',
                    // style: getDefaultTextHintStyle(context),
                  ),
                  SizedBox(height: gapHeight),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: PinCodeTextField(
                        autoFocus: false,
                        cursorWidth: 0.2,
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.red.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                        length: 4,
                        obscureText: true,
                        obscuringCharacter: '*',
                        blinkWhenObscuring: true,
                        autovalidateMode: AutovalidateMode.disabled,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 4) {
                            return "enter otp";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            activeBorderWidth: 0.9,
                            disabledBorderWidth: 0.9,
                            inactiveBorderWidth: 0.9,
                            borderWidth: 0.9,
                            selectedBorderWidth: 0.9,
                            borderRadius: BorderRadius.circular(2),
                            fieldHeight: 40,
                            fieldWidth: 40,
                            activeColor: themeData.primaryColorDark,
                            activeFillColor: Colors.transparent,
                            inactiveFillColor: Colors.transparent,
                            inactiveColor: Colors.grey,
                            selectedFillColor: Colors.transparent,
                            selectedColor: Colors.grey.shade500),
                        cursorColor: themeData.primaryColorDark,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: OTPController,
                        keyboardType: TextInputType.number,
                        textStyle: TextStyle(color: themeData.primaryColorDark),
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          // setState(() {
                            currentText = value;
                            if (currentText.length == 4) {
                              if (pin == OTPController.text) {
                                hasError = false;
                                checkForNotification();
                              } else {
                                // Constants.showSnackBar(context, "Error!! Wrong pin");
                              }
                            }
                          // });
                          // conditions for validating
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          return true;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: gapHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            // forgotPinAlert();
                            showAlertDialog(context);
                          },
                          child: Text('Forgot PIN? ')),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Visibility(
              visible: isBiometricVisible,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    // width: 190,
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(15)), border: Border.all(color: themeData.primaryColorDark, width: 0.1)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "ENABLE BIOMETRIC  ",
                                style: GoogleFonts.poppins(textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                              ),
                              const Icon(Icons.fingerprint)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Login Now"),
      onPressed:  () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithOTPLessScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning!"),
      content: Text("To reset PIN you need to Re-Login"),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void forgotPinAlert() {
    showDialog(
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              alignment: Alignment.center,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white54, width: 0.4),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              // elevation: 5,
              insetPadding: const EdgeInsets.all(2.0),
              title: Text(
                'To reset PIN you need to Re-Login',
              ),
              titlePadding: EdgeInsets.symmetric(vertical: 10),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  child: Text('Login now'),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(' Cancel ')),
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

  void checkForNotification() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
          (Route<dynamic> route) => false,
    );
    // bool status = _messagingService.getRemoteMessageExists();
    // print('CSDCSDCSDCDC   $status   $CONTACT_ID');
    // if (status) {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => NotificationProcessor(
    //           loanid: LOAN_ID,
    //           contactId: CONTACT_ID,
    //         )),
    //         (Route<dynamic> route) => false,
    //   );
    // } else {
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => const DashBoardScreen()),
    //         (Route<dynamic> route) => false,
    //   );
    // }
  }
}

