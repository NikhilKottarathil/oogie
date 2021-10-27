import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_location.dart';

class VerifyOTP extends StatefulWidget {
  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController mobileController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();
  SharedPreferences sharedPreferences;
  String token, otp, errorMessage;
  int step = 1;
  bool isMobileValid = true;
  bool isOtpValid = true;
  Timer _timer;
  int pendingTimeInMills = 60000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
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
      appBar: defaultAppBarWhite(context: context, text: 'Register'),
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
                      'Verify OTP',
                      style: TextStyles.largeRegular,
                    ),
                    CustomTextField(
                      hintText: 'Enter OTP',

                    ),
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
                        child: Text(    getDurationTime(pendingTimeInMills.toString()),style: TextStyles.smallMedium,),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    DefaultButton(
                      text:'Verify & Register',
                      action: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddLocation()));

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
