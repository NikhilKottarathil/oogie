import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/ui_widgets/custom_image_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/authentication/auth_credentials.dart';
import 'package:oogie/screens/authentication/sign_up/sign_up_bloc.dart';
import 'package:oogie/screens/authentication/sign_up/sign_up_events.dart';
import 'package:oogie/screens/authentication/sign_up/sign_up_state.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_bloc.dart';
import 'package:oogie/screens/authentication/verfiy_sign_up/verify_signup_view.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(
          context: context,
          text: 'Register',
          prefixAction: () {},
          prefixWidget: Container()),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            showSnackBar(context, formStatus.exception);
          } else if (formStatus is SubmissionSuccess) {
            AuthCredentials authCredentials = AuthCredentials(
                userName: state.userName,
                phoneNumber: state.phoneNumber,
                password: state.password,
                generatedOTP: state.generatedOTP);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (__) => VerifySignUpBloc(
                        authRepo: context.read<SignUpBloc>().authRepo,
                        authCredentials: authCredentials),
                    child: VerifySignUpView(),
                  ),
                ));
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
                          height: 24,
                        ),
                        Text(
                          'Create an account',
                          style: TextStyles.largeRegular,
                        ),
                        Text(
                          'Note: We will send an OTP to the mobile number entered below',
                          style: TextStyles.smallRegularSubdued,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return CustomTextField(
                                hintText: 'Name',
                                maxLines: 1,
                                prefixIcon: 'icons/user.svg',
                                validator: (value) {
                                  return state.userNameValidationText;
                                },
                                text: state.userName,
                                onChange: (value) {
                                  context.read<SignUpBloc>().add(
                                        SignUpUsernameChanged(username: value),
                                      );
                                },
                                textInputType: TextInputType.text);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return CustomTextField(
                                hintText: 'Mobil Number',
                                maxLines: 1,
                                prefixIcon: 'icons/smartphone.svg',
                                validator: (value) {
                                  return state.phoneNumberValidationText;
                                },
                                text: state.phoneNumber,
                                onChange: (value) {
                                  context.read<SignUpBloc>().add(
                                        SignUpPhoneNumberChangeChanged(
                                            phoneNumber: value),
                                      );
                                },
                                textInputType: TextInputType.number);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return CustomTextField(
                                hintText: 'Set Password',
                                prefixIcon: 'icons/lock.svg',
                                validator: (value) {
                                  return state.passwordValidationText;
                                },
                                text: state.password,
                                onChange: (value) {
                                  context.read<SignUpBloc>().add(
                                        SignUpPasswordChanged(password: value),
                                      );
                                },
                                textInputType: TextInputType.visiblePassword);
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return state.formStatus is FormSubmitting
                                ? CustomProgressIndicator()
                                : DefaultButton(
                                    text: "Continue",
                                    action: () {
                                      if (_formKey.currentState.validate()) {
                                        context
                                            .read<SignUpBloc>()
                                            .add(SignUpSubmitted());
                                      }
                                    },
                                  );
                          },
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageButton(
                              image: 'assets/facebook.svg',
                              action: () {},
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            CustomImageButton(
                              image: 'assets/google.svg',
                              action: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have account?",
                              style: TextStyles.smallRegular,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomTextButton2(
                              text: 'Login',
                              action: () {
                                // context.read<AuthCubit>().showLogin();
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16,
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
