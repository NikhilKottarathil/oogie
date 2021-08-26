import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_image_button.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/password_text_field.dart';
import 'package:oogie/screens/authentication/add_location.dart';
import 'package:oogie/screens/authentication/login_with_otp.dart';
import 'package:oogie/screens/authentication/register.dart';
import 'package:oogie/screens/explore/explore_page.dart';
import 'package:oogie/screens/vendor/home_page.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
        return SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: height * .35,
                color: AppColors.PrimaryBase,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/app_logo.svg',
                    fit: BoxFit.cover,
                    height: height * .08,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height * .35 - 25-16, left: 20, right: 20, bottom: 20),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            CustomTextField(
                                hintText: 'Mobile Number',
                                maxLines: 1,
                                prefixIcon: 'icons/smartphone.svg',isLabelEnabled: false,),
                            PasswordTextField(
                              hintText: 'Password',
                              prefixIcon: 'icons/lock.svg',
                              isLabelEnabled: false,
                              isValid: true,
                            ),
                            DefaultButton(text: 'Login',action: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

                            },),
                            CustomTextButton(text:'Login with OTP',action: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithOtp()));
                            },),

                          ],
                        ),

                        Spacer(),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     CustomImageButton(image: 'assets/facebook.svg',action: (){},),
                        //     SizedBox(width: 32,),
                        //     CustomImageButton(image: 'assets/google.svg',action: (){},),
                        //   ],
                        // ),
                        // SizedBox(height: 32,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("Don't have any account?",style: AppStyles.smallRegular,),
                        //     SizedBox(width: 5,),
                        //     CustomTextButton2(text: 'Register',action: (){
                        //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register()));
                        //
                        //     },)
                        //   ],
                        // ),
                        // SizedBox(height: 16,),
                        // CustomTextButton2(text: 'Continue as Guest',action: (){},),
                        // SizedBox(height: 16,),

                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      }),
    );
  }
}
