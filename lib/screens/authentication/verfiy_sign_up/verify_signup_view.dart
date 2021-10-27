import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_progress_indicator.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_bloc.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_events.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_state.dart';


class VerifySignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Register'),

      body: BlocListener<VerifySignUpBloc, VerifySignUpState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            showSnackBar(context, formStatus.exception);
          } else if (formStatus is SubmissionSuccess) {
           Navigator.pushReplacementNamed(context, '/myLocation');
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
                        Text(
                          'Verify OTP',
                          style: TextStyles.largeRegular,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        BlocBuilder<VerifySignUpBloc, VerifySignUpState>(
                            builder: (context, state) {
                          return CustomTextField(
                              hintText: 'Enter OTP',
                              validator: (value) {
                                return state.otpValidationText;
                              },
                              text: state.otp,
                              onChange: (value) {
                                context.read<VerifySignUpBloc>().add(
                                      VerifySignUpOtpChanged(otp: value),
                                    );
                              },
                              textInputType: TextInputType.number);
                        }),BlocBuilder<VerifySignUpBloc, VerifySignUpState>(
                            builder: (context, state) {
                          return Column(
                            children: [
                              Visibility(
                                visible: state.otpState == OTPState.showResendOTP,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CustomTextButton2(
                                    text: 'Resend OTP',
                                    action: () {
                                      context.read<VerifySignUpBloc>().add(ResendOTPSubmitted());
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: state.otpState == OTPState.showTimer,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(    getDurationTime(state.pendingTimeInMills.toString()),style: TextStyles.smallMedium,),
                                ),
                              ),
                            ],
                          );
                        }),

                        SizedBox(
                          height: 16,
                        ),
                        BlocBuilder<VerifySignUpBloc, VerifySignUpState>(
                            builder: (context, state) {
                          return state.formStatus is FormSubmitting
                              ? CustomProgressIndicator()
                              : DefaultButton(
                              text:'Verify & Register',
                                  action: () {
                                    if (_formKey.currentState.validate()) {
                                      context
                                          .read<VerifySignUpBloc>()
                                          .add(VerifySignUpSubmitted());
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
    );
  }

}
