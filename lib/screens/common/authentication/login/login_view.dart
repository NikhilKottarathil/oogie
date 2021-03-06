import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/common/authentication/login/login_bloc.dart';
import 'package:oogie/screens/common/authentication/login/login_events.dart';
import 'package:oogie/screens/common/authentication/login/login_state.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            showSnackBar(context, formStatus.exception);
          } else if (formStatus is SubmissionSuccess) {
            if (FlavorConfig().flavorName == 'user') {
              print('selectedLocationId ${appDataModel.selectedLocationId}');
              if (appDataModel.selectedLocationId != null) {
                Navigator.pushReplacementNamed(context, '/explore');
              } else {
                Navigator.pushReplacementNamed(context, '/myLocation');
              }
            } else {
              Navigator.pushReplacementNamed(context, '/home');
            }
          }
        },
        child: Form(
          key: _formKey,
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: height * .35,
                    color: AppColors.PrimaryBase,
                    child: Center(
                      // child: SvgPicture.asset(
                      //   'assets/app_logo.svg',
                      //   fit: BoxFit.cover,
                      //   height: height * .08,
                      // ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (FlavorConfig().flavorName == 'user')
                            SvgPicture.asset(
                              'assets/app_logo.svg',
                              fit: BoxFit.cover,
                              height: height * .08,
                            ),
                          if (FlavorConfig().flavorName == 'vendor')
                            Image.asset(
                              'assets/vendor_white.png',
                              fit: BoxFit.cover,
                              height: height * .08,
                            ),
                          if (FlavorConfig().flavorName == 'wholesale_dealer')
                            Image.asset(
                              'assets/wholesale_white.png',
                              fit: BoxFit.cover,
                              height: height * .08,
                            ),
                          if (FlavorConfig().flavorName == 'distributor')
                            Image.asset(
                              'assets/distributor_white.png',
                              fit: BoxFit.cover,
                              height: height * .08,
                            ),
                          if (FlavorConfig().flavorName == 'sales_executive')
                            Image.asset(
                              'assets/sales_executive_white.png',
                              fit: BoxFit.cover,
                              height: height * .08,
                            ),
                          if (FlavorConfig().flavorName == 'delivery_partner')
                            Image.asset(
                              'assets/delivery_partner_white.png',
                              fit: BoxFit.cover,
                              height: height * .08,
                            ),
                        ],
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: (height * .35) - 25 - 16,
                          left: 20,
                          right: 20,
                          bottom: 20),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                              return CustomTextField(
                                hintText: "Phone  Number",
                                text: state.phoneNumber,
                                textInputType: TextInputType.phone,
                                validator: (value) {
                                  return state.phoneNumberValidationText;
                                },
                                onChange: (value) {
                                  context.read<LoginBloc>().add(
                                        LoginPhoneNumberChanged(
                                            phoneNumber: value),
                                      );
                                },
                                maxLines: 1,
                                prefixIcon: 'icons/smartphone.svg',
                                isLabelEnabled: false,
                              );
                            }),

                            BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                              return CustomTextField(
                                  hintText: "Password",
                                  validator: (value) {
                                    return state.passwordValidationText;
                                  },
                                  text: state.password,
                                  onChange: (value) {
                                    context.read<LoginBloc>().add(
                                          LoginPasswordChanged(password: value),
                                        );
                                  },
                                  prefixIcon: 'icons/lock.svg',
                                  isLabelEnabled: false,
                                  textInputType: TextInputType.visiblePassword);
                            }),

                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: InkWell(
                            //     onTap: () {
                            //       context.read<AuthCubit>().showResetPassword() ;
                            //     },
                            //     child: Text(
                            //       "Forgot password?",
                            //       style: TextStyles.smallBoldTextPrimary,
                            //     ),
                            //   ),
                            // ),
                            BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                              return state.formStatus is FormSubmitting
                                  ? CustomProgressIndicator()
                                  : DefaultButton(
                                      text: "Login",
                                      action: () {
                                        if (_formKey.currentState.validate()) {
                                          context
                                              .read<LoginBloc>()
                                              .add(LoginSubmitted());
                                        }
                                      });
                            }),
                            CustomTextButton(
                              text: 'Login with OTP',
                              action: () {
                                Navigator.pushNamed(context, '/otpLogin');
                              },
                            ),
                            Spacer(),

                            Visibility(
                                visible: FlavorConfig().flavorName == 'user',
                                child: Column(
                                  children: [
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     CustomImageButton(
                                    //       image: 'assets/facebook.svg',
                                    //       action: () {},
                                    //     ),
                                    //     SizedBox(
                                    //       width: 32,
                                    //     ),
                                    //     CustomImageButton(
                                    //       image: 'assets/google.svg',
                                    //       action: () {},
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Don't have any account?",
                                          style: TextStyles.smallRegular,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CustomTextButton2(
                                          text: 'Register',
                                          action: () {
                                            Navigator.pushReplacementNamed(
                                                context, '/signUp');
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    CustomTextButton2(
                                      text: 'Continue as Guest',
                                      action: () {
                                        Navigator.pushReplacementNamed(
                                            context, '/myLocation');
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
