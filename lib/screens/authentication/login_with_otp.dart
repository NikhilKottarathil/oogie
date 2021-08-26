import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/screens/vendor/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_location.dart';

class LoginWithOtp extends StatefulWidget {
  @override
  _LLoginWithOtpState createState() => _LLoginWithOtpState();
}

class _LLoginWithOtpState extends State<LoginWithOtp> {
  TextEditingController mobileController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  SharedPreferences sharedPreferences;
  String token, otp, errorMessage;
  int step = 0;
  bool isMobileValid = true;
  bool isOtpValid = true;
  Timer _timer;
  int pendingTimeInMills = 60000;

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();

    super.dispose();

    // getDurationTime(pendingTimeInMills.toString()
  }
  void startTimer() {
    const oneSec = const Duration(milliseconds: 1000);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (pendingTimeInMills <= 1000) {
          setState(() {
            timer.cancel();
            // step++;
            step=2;

          });
        } else {
          setState(() {
            pendingTimeInMills -= 1000;
          });
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Login with OTP'),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * .08,
                    ),
                    Text(
                      step == 0 ? 'Enter mobile number' : 'Verify OTP',
                      style: AppStyles.largeRegular,
                    ),
                    Visibility(
                        visible: step == 0,
                        child: CustomTextField(
                          hintText: 'Mobile Number',
                          prefixIcon: 'icons/smartphone.svg',
                        )),
                    Visibility(
                        visible: step != 0,
                        child: CustomTextField(
                          hintText: 'Enter OTP',

                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: step == 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton2(
                          text: 'Resend OTP',
                          action: () {
                            step = 2;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: step == 1,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(    getDurationTime(pendingTimeInMills.toString()),style: AppStyles.smallMedium,),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    DefaultButton(
                      text: step == 0 ? 'Send OTP' : 'Verify & Login',
                      action: () {
                        if (step != 0) {
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddLocation()));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        } else {
                          step++;
                          startTimer();
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
