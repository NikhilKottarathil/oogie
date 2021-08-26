import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_image_button.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/password_text_field.dart';
import 'package:oogie/screens/authentication/login.dart';
import 'package:oogie/screens/authentication/login_with_otp.dart';
import 'package:oogie/screens/authentication/verify_otp.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context,text: 'Register',prefixAction: (){},prefixWidget: Container()),
      body: LayoutBuilder(
          builder: (context, constraints) {
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            SizedBox(height: 24,),
                            Text('Create an account',style: AppStyles.largeRegular,),
                            Text('Note: We will send an OTP to the mobile number entered below',style: AppStyles.smallRegularSubdued,),
                            CustomTextField(
                                hintText: 'Name',
                                maxLines: 1,
                                prefixIcon: 'icons/user.svg'),
                            CustomTextField(
                                hintText: 'Mobil Number',
                                maxLines: 1,
                                prefixIcon: 'icons/smartphone.svg'),
                            PasswordTextField(
                              hintText: 'Set Password',
                              prefixIcon: 'icons/lock.svg',
                              isValid: true,
                            ),
                            DefaultButton(text: 'Continue',action: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyOTP()));
                            },),
                          ],
                        ),

                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageButton(image: 'assets/facebook.svg',action: (){},),
                            SizedBox(width: 32,),
                            CustomImageButton(image: 'assets/google.svg',action: (){},),
                          ],
                        ),
                        SizedBox(height: 32,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have account?",style: AppStyles.smallRegular,),
                            SizedBox(width: 5,),
                            CustomTextButton2(text: 'Login',action: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));

                            },)
                          ],
                        ),
                        SizedBox(height: 16,),

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
