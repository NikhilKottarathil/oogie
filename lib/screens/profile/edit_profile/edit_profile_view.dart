import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';
import 'package:oogie/components/custom_text_field_3.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/profile/edit_profile/edit_profile_bloc.dart';
import 'package:oogie/screens/profile/edit_profile/edit_profile_event.dart';
import 'package:oogie/screens/profile/edit_profile/edit_profile_state.dart';
import 'package:oogie/screens/profile/profile/profile_bloc.dart';

class EditProfileView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: defaultAppBarBlue(context: buildContext, text: 'Edit Profile'),
      body: BlocProvider(
        create: (context) => EditProfileBloc(
          profileRepository: context.read<ProfileBloc>().profileRepository,
          profileBloc: context.read<ProfileBloc>(),
        ),
        child: BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is SubmissionFailed) {
              showSnackBar(context, formStatus.exception);
            } else if (formStatus is SubmissionSuccess) {
              // buildContext.read<ProfileBloc>().getUserData();
              Navigator.of(buildContext).pop();
            }
          },
          child: Material(
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
                              height: 100,
                            ),
                            // Text(
                            //   'Edit Profile',
                            //   style: TextStyles.largeRegularTertiary,
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            BlocBuilder<EditProfileBloc, EditProfileState>(
                              builder: (context, state) {
                                return CustomTextField3(
                                    hintText: "User Name",
                                    validator: (value) {
                                      return state.userNameValidationText;
                                    },
                                    text: state.userName,
                                    onChange: (value) {
                                      context.read<EditProfileBloc>().add(
                                            EditProfileUsernameChanged(
                                                username: value),
                                          );
                                    },
                                    textInputType: TextInputType.text);
                              },
                            ),
                            dividerDefault,
                            SizedBox(
                              height: 20,
                            ),

                            BlocBuilder<EditProfileBloc, EditProfileState>(
                              builder: (context, state) {
                                return CustomTextField3(
                                    hintText: "Phone  Number",
                                    validator: (value) {
                                      return state.phoneNumberValidationText;
                                    },
                                    text: state.phoneNumber,
                                    onChange: (value) {
                                      context.read<EditProfileBloc>().add(
                                            EditProfilePhoneNumberChangeChanged(
                                                phoneNumber: value),
                                          );
                                    },
                                    textInputType: TextInputType.number);
                              },
                            ),
                            dividerDefault,

                            SizedBox(
                              height: 20,
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            BlocBuilder<EditProfileBloc, EditProfileState>(
                              builder: (context, state) {
                                return state.formStatus is FormSubmitting
                                    ? CustomProgressIndicator()
                                    : DefaultButton(
                                        text: "Save",
                                        action: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            context
                                                .read<EditProfileBloc>()
                                                .add(EditProfileSubmitted());
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
        ),
      ),
    );
  }
}
