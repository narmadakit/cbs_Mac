
import 'dart:async';
import 'dart:io';
import 'package:finsta_mac/Login/model/GetOtpModel.dart';
import 'package:finsta_mac/network/Repository.dart';
import 'package:finsta_mac/utils/AppStyles.dart';
import 'package:finsta_mac/utils/SharedPrefs.dart';
import 'package:finsta_mac/view/MembersScreen.dart';
import 'package:finsta_mac/view/UsepinScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Home/bloc/HomeState.dart';
import '../components/AppWidgets.dart';
import '../components/CustomMainBackground.dart';
import '../utils/AppText.dart';

class OtpScreen extends StatefulWidget {
  final GetOtpModel? model;
  const OtpScreen({super.key,this.model});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool loadingVisibility = false;
  Repository repo=Repository();

  static const int countdownDuration = 3 * 60;
  bool showTimer = false; // 3 minutes in seconds
  int remainingSeconds = countdownDuration;
  Timer? timer;
  int? otp;
  late OTPInteractor _otpInteractor;
  OTPTextEditController otpController = OTPTextEditController(codeLength: 6);

  void startTimer() {
    showTimer = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        setState(() {
          showTimer = false;
        });
        timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();

    // You can receive your app signature by using this method.
    if(Platform.isAndroid) {
      final appSignature = await _otpInteractor.getAppSignature();
      if (kDebugMode) {
        print('Your app signature: $appSignature');
      }
    }
  }

  Future<void> requestPermissions() async {
    if (await Permission.sms.isDenied) {
      await Permission.sms.request();
    }
  }

  @override
  void initState() {
    // OtpAutofill().start();
    requestPermissions();
    startTimer();
    _initInteractor();
    if (Platform.isAndroid) {
      otpController = OTPTextEditController(
        codeLength: 6,
        onCodeReceive: (code) => print('Your Application receive code - $code'),
        otpInteractor: _otpInteractor,
      )
        ..startListenUserConsent(
              (code) {
            final exp = RegExp(r'(\d{6})');
            return exp.stringMatch(code ?? '') ?? '';
          },
        );
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMainBackground(
        title: '',
        body:blocBuilder(context)
    );
  }

  validateOtp(String mobile, String otp) async {
   String date = '${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}';
    var data = await repo.validateOtpRepo(mobile,otpController.text,date);
    print("validateOtp -----${data}");

    if(data == 'true'){
      SharedPrefs.saveBool(SharedPrefs.isLogin, true);
      SharedPrefs.saveString(SharedPrefs.mobileNo, mobile);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => const UsePinScreen(
      //         )));
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MembersScreen(
              )));
    }
    else{
      if (!mounted) return;
      showSnackBar(context, 'Enter Correct OTP');
    }

  }

  Widget blocBuilder(BuildContext context){
    return Center(
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Image.memory(widget.model?.bytesLogo),
                Center(child: Lottie.asset('assets/images/OTP.json', width: 350, height:300)),
                const SizedBox(height: 50,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OTP",
                      style: AppStyles.headerLargeText,
                    ),
                    Text(
                      "Enter the OTP sent to ${widget.model?.mobileNumber}",
                      // style: GoogleFonts.poppins(textStyle: GoogleFonts.poppins()),
                    ),
                    // Text(
                    //   "${widget.model?.otp}",
                    // ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      child: PinCodeTextField(
                        autoFocus: false,
                        appContext: context,
                        length: 6,
                        controller: otpController,
                        autoDisposeControllers: false,
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        obscureText: false,
                        animationType: AnimationType.fade,
                        useHapticFeedback: true,
                        keyboardType: TextInputType.number,
                        hapticFeedbackTypes: HapticFeedbackTypes.light,
                        cursorColor: Colors.black,
                        cursorWidth: 2,
                        animationDuration: const Duration(milliseconds: 300),
                        pinTheme: PinTheme(
                          inactiveBorderWidth: 0.8,
                          activeBorderWidth: 0.8,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: MediaQuery.of(context).size.height * 0.06,
                          fieldWidth: MediaQuery.of(context).size.height * 0.059,
                          activeColor: AppStyles.btnColor,
                          inactiveColor: AppStyles.btnColor,
                          selectedColor:AppStyles.btnColor,
                          activeFillColor: AppStyles.btnColor,
                        ),
                        onCompleted: (otp) {
                          otpController.text = otp;
                          // verifyOTP(OTP);
                          print("onCompleted $otp");
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: payButton((){
                            if(otpController.text == ""){
                              showSnackBar(context, 'Please enter OTP');
                            }
                            else{
                              validateOtp(widget.model?.mobileNumber,otpController.text);
                            }
                          }, validateOtpText),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }

  void blocListener(BuildContext context, state){
    if(state is HomeLoadingState ){
      loadingVisibility=true;
    }else if(state is HomeSuccessState){

    }
  }

}
