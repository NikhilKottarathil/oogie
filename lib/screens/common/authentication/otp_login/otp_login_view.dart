import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/screens/common/authentication/otp_login/otp_login_bloc.dart';
import 'package:oogie/screens/common/authentication/otp_login/otp_login_events.dart';
import 'package:oogie/screens/common/authentication/otp_login/otp_login_state.dart';
import 'package:oogie/screens/common/authentication/verfiy_sign_up/verify_signup_state.dart';

class OTPLoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Login with OTP'),
      body: BlocProvider(
        create: (context) => OTPLoginBloc(authRepo: AuthRepository()),
        child: BlocListener<OTPLoginBloc, OTPLoginState>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is SubmissionFailed) {
              showSnackBar(context, formStatus.exception);
            } else if (formStatus is SubmissionSuccess) {
              Navigator.of(context).pop();
              print(FlavorConfig().flavorName);

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
            child: Padding(
              padding: EdgeInsets.all(20),
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * .08,
                          ),
                          BlocBuilder<OTPLoginBloc, OTPLoginState>(
                              builder: (context, state) {
                            return Text(
                              state.otpState == OTPState.showPhoneNumber
                                  ? 'Enter mobile number'
                                  : 'Verify OTP',
                              style: TextStyles.largeRegular,
                            );
                          }),
                          BlocBuilder<OTPLoginBloc, OTPLoginState>(
                              builder: (context, state) {
                            return Visibility(
                              visible:
                                  state.otpState == OTPState.showPhoneNumber,
                              child: CustomTextField(
                                  hintText: 'Mobile Number',
                                  validator: (value) {
                                    return state.phoneNumberValidationText;
                                  },
                                  prefixIcon: 'icons/smartphone.svg',
                                  text: state.otp,
                                  onChange: (value) {
                                    context.read<OTPLoginBloc>().add(
                                          PhoneNumberChanged(
                                              phoneNumber: value),
                                        );
                                  },
                                  textInputType: TextInputType.number),
                            );
                          }),
                          BlocBuilder<OTPLoginBloc, OTPLoginState>(
                              builder: (context, state) {
                            return Visibility(
                              visible:
                                  state.otpState != OTPState.showPhoneNumber,
                              child: CustomTextField(
                                  hintText: 'Enter OTP',
                                  validator: (value) {
                                    return state.otpValidationText;
                                  },
                                  text: state.otp,
                                  onChange: (value) {
                                    context.read<OTPLoginBloc>().add(
                                          OTPChanged(otp: value),
                                        );
                                  },
                                  textInputType: TextInputType.number),
                            );
                          }),
                          SizedBox(
                            height: 5,
                          ),
                          BlocBuilder<OTPLoginBloc, OTPLoginState>(
                              builder: (context, state) {
                            return Column(
                              children: [
                                Visibility(
                                  visible:
                                      state.otpState == OTPState.showResendOTP,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomTextButton2(
                                      text: 'Resend OTP',
                                      action: () {
                                        context
                                            .read<OTPLoginBloc>()
                                            .add(ResendOTPSubmitted());
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: state.otpState == OTPState.showTimer,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      getDurationTime(
                                          state.pendingTimeInMills.toString()),
                                      style: TextStyles.smallMedium,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<OTPLoginBloc, OTPLoginState>(
                              builder: (context, state) {
                            return state.formStatus is FormSubmitting
                                ? CustomProgressIndicator()
                                : DefaultButton(
                                    text: state.otpState ==
                                            OTPState.showPhoneNumber
                                        ? 'Send OTP'
                                        : 'Verify & Login',
                                    action: () {
                                      if (_formKey.currentState.validate()) {
                                        if (state.otpState ==
                                            OTPState.showPhoneNumber) {
                                          context
                                              .read<OTPLoginBloc>()
                                              .add(GetOTPSubmitted());
                                        } else {
                                          context
                                              .read<OTPLoginBloc>()
                                              .add(OTPLoginSubmitted());
                                        }
                                      }
                                    });
                          }),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
