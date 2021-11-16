import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/common/authentication/reset_password/reset_password_bloc.dart';
import 'package:oogie/screens/common/authentication/reset_password/reset_password_event.dart';
import 'package:oogie/screens/common/authentication/reset_password/reset_password_state.dart';
import 'package:oogie/screens/common/authentication/reset_password/reset_password_status.dart';

class ResetPasswordView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is MobileNumberSubmitFailed) {
          showSnackBar(context, formStatus.exception);
        }
        if (formStatus is OTPSubmitFailed) {
          showSnackBar(context, formStatus.exception);
        }
        if (formStatus is NewPasswordSubmitFailed) {
          showSnackBar(context, formStatus.exception);
        }
      },
      child: Scaffold(
        appBar: defaultAppBarWhite(
            context: buildContext,
            text: 'Reset Password',
            prefixAction: () {
              ResetPasswordStatus formStatus =
                  buildContext.read<ResetPasswordBloc>().state.formStatus;
              if (formStatus is InitialStatus ||
                  formStatus is MobileNumberSubmitting ||
                  formStatus is MobileNumberSubmitFailed ||
                  formStatus is NewPasswordSubmittedSuccessfully) {
                Navigator.of(buildContext).pop();
              } else {
                print('reverse buttn submit');

                buildContext.read<ResetPasswordBloc>().add(ReverseButtonSubmitted());
              }
            }),
        body: Form(
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
                          height: 100,
                        ),
                        BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                          builder: (context, state) {
                            return state.formStatus is InitialStatus ||
                                    state.formStatus
                                        is MobileNumberSubmitting ||
                                    state.formStatus is MobileNumberSubmitFailed
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Enter mobile number',
                                        style: TextStyles.largeRegularSubdued,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CustomTextField(
                                          hintText: "phone number",
                                          validator: (value) {
                                            return state
                                                .phoneNumberValidationText;
                                          },
                                          text: state.phoneNumber,
                                          onChange: (value) {
                                            context
                                                .read<ResetPasswordBloc>()
                                                .add(
                                                  ForgotPhoneNumberChanged(
                                                      phoneNumber: value),
                                                );
                                          },
                                          prefixIcon: 'icons/smartphone.svg',
                                          textInputType: TextInputType.phone),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                        BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                          builder: (context, state) {
                            return state.formStatus
                                        is MobileNumberSubmittedSuccessfully ||
                                    state.formStatus is OTPSubmitting ||
                                    state.formStatus is OTPSubmitFailed
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Verify OTP',
                                        style: TextStyles.largeRegularSubdued,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CustomTextField(
                                          hintText: "Enter OTP",
                                          validator: (value) {
                                            return state.otpValidationText;
                                          },
                                          text: state.otp,
                                          onChange: (value) {
                                            context
                                                .read<ResetPasswordBloc>()
                                                .add(
                                                  ForgotOTPChanged(otp: value),
                                                );
                                          },
                                          textInputType: TextInputType.number),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                        BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                          builder: (context, state) {
                            return state.formStatus
                                        is OTPSubmittedSuccessfully ||
                                    state.formStatus is NewPasswordSubmitting ||
                                    state.formStatus is NewPasswordSubmitFailed
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Enter New Password',
                                        style: TextStyles.largeRegularSubdued,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CustomTextField(
                                          hintText: "Password",
                                          validator: (value) {
                                            return state.passwordValidationText;
                                          },
                                          text: state.password,
                                          onChange: (value) {
                                            context
                                                .read<ResetPasswordBloc>()
                                                .add(
                                                  ResetPasswordChanged(
                                                      password: value),
                                                );
                                          },
                                          prefixIcon: 'icons/lock.svg',
                                          textInputType:
                                              TextInputType.visiblePassword),
                                    ],
                                  )
                                : Container();
                          },
                        ),
                        BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                          builder: (context, state) {
                            return state.formStatus
                                    is NewPasswordSubmittedSuccessfully
                                ? Text(
                                    'Password Changed Successfully',
                                    style: TextStyles.largeRegularSubdued,
                                  )
                                : Container();
                          },
                        ),
                        BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                          builder: (context, state) {
                            return state.formStatus is NewPasswordSubmitting ||
                                    state.formStatus
                                        is MobileNumberSubmitting ||
                                    state.formStatus is OTPSubmitting
                                ? CustomProgressIndicator()
                                : DefaultButton(
                                    text: state.formStatus is InitialStatus
                                        ? "Send OTP"
                                        : state.formStatus
                                                is MobileNumberSubmittedSuccessfully
                                            ? 'Verify'
                                            : state.formStatus
                                                    is OTPSubmittedSuccessfully
                                                ? 'Reset Password'
                                                : 'OK',
                                    action: () {
                                      if (state.formStatus
                                          is NewPasswordSubmittedSuccessfully) {
                                        Navigator.of(context).pop();
                                      } else {
                                        if (_formKey.currentState.validate()) {
                                          context
                                              .read<ResetPasswordBloc>()
                                              .add(ButtonSubmitted());
                                        }
                                      }
                                    },
                                  );
                          },
                        ),
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
