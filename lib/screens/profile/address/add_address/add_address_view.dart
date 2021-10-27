import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';

import 'package:oogie/components/custom_progress_indicator.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/profile/address/add_address/add_address_bloc.dart';
import 'package:oogie/screens/profile/address/add_address/add_address_event.dart';
import 'package:oogie/screens/profile/address/add_address/add_address_state.dart';

class AddAddressView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: defaultAppBarBlue(context: buildContext, text: 'Add Address'),
      body: BlocListener<AddAddressBloc, AddAddressState>(
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
                          BlocBuilder<AddAddressBloc, AddAddressState>(
                            builder: (context, state) {
                              return CustomTextField(
                                  hintText: "Name  (Required)",
                                  validator: (value) {
                                    return state.userNameValidationText;
                                  },
                                  text: state.userName,
                                  onChange: (value) {
                                    context.read<AddAddressBloc>().add(
                                          UsernameChanged(value: value),
                                        );
                                  },
                                  textInputType: TextInputType.text);
                            },
                          ),
                          BlocBuilder<AddAddressBloc, AddAddressState>(
                            builder: (context, state) {
                              return CustomTextField(
                                  hintText: "Phone  Number (Required)",
                                  validator: (value) {
                                    return state.phoneNumberValidationText;
                                  },
                                  text: state.phoneNumber,
                                  onChange: (value) {
                                    context.read<AddAddressBloc>().add(
                                          PhoneNumberChanged(value: value),
                                        );
                                  },
                                  textInputType: TextInputType.number);
                            },
                          ),
                          BlocBuilder<AddAddressBloc, AddAddressState>(
                            builder: (context, state) {
                              return CustomTextField(
                                  hintText:
                                      "Alternative Phone Number (Required)",
                                  validator: (value) {
                                    return state
                                        .alternativePhoneNumberValidationText;
                                  },
                                  text: state.alternativePhoneNumber,
                                  onChange: (value) {
                                    context.read<AddAddressBloc>().add(
                                          AlternativePhoneNumberChanged(
                                              value: value),
                                        );
                                  },
                                  textInputType: TextInputType.number);
                            },
                          ),
                          BlocBuilder<AddAddressBloc, AddAddressState>(
                            builder: (context, state) {
                              return CustomTextField(
                                  hintText: "City (Required)",
                                  validator: (value) {
                                    return state.cityValidationText;
                                  },
                                  text: state.city,
                                  onChange: (value) {
                                    context.read<AddAddressBloc>().add(
                                          CityChanged(value: value),
                                        );
                                  },
                                  textInputType: TextInputType.text);
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: BlocBuilder<AddAddressBloc,
                                    AddAddressState>(
                                  builder: (context, state) {
                                    return CustomTextField(
                                        hintText: "Pincode (Required)",
                                        validator: (value) {
                                          return state.pinCodeValidationText;
                                        },
                                        text: state.pinCode,
                                        onChange: (value) {
                                          context.read<AddAddressBloc>().add(
                                                PincodeChanged(value: value),
                                              );
                                        },
                                        textInputType: TextInputType.number);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: BlocBuilder<AddAddressBloc,
                                    AddAddressState>(
                                  builder: (context, state) {
                                    return CustomTextField(
                                        hintText: "State (Required)",
                                        validator: (value) {
                                          return state.stateValidationText;
                                        },
                                        text: state.state,
                                        onChange: (value) {
                                          context.read<AddAddressBloc>().add(
                                                StateChanged(value: value),
                                              );
                                        },
                                        textInputType: TextInputType.text);
                                  },
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<AddAddressBloc, AddAddressState>(
                            builder: (context, state) {
                              return CustomTextField(
                                  hintText:
                                      "House No, Building Name (Required)",
                                  validator: (value) {
                                    return state.address1ValidationText;
                                  },
                                  text: state.address1,
                                  onChange: (value) {
                                    context.read<AddAddressBloc>().add(
                                          Address1Changed(value: value),
                                        );
                                  },
                                  textInputType: TextInputType.text);
                            },
                          ),
                          BlocBuilder<AddAddressBloc, AddAddressState>(
                            builder: (context, state) {
                              return CustomTextField(
                                  hintText: "Road name, Area (Required)",
                                  validator: (value) {
                                    return state.address2ValidationText;
                                  },
                                  text: state.address2,
                                  onChange: (value) {
                                    context.read<AddAddressBloc>().add(
                                          Address2Changed(value: value),
                                        );
                                  },
                                  textInputType: TextInputType.text);
                            },
                          ),
                          BlocBuilder<AddAddressBloc, AddAddressState>(
                            builder: (context, state) {
                              return CustomTextField(
                                  hintText: "Landmark",
                                  validator: (value) {
                                    return null;
                                  },
                                  text: state.landmark,
                                  onChange: (value) {
                                    context.read<AddAddressBloc>().add(
                                          LandmarkChanged(value: value),
                                        );
                                  },
                                  textInputType: TextInputType.text);
                            },
                          ),
                          Spacer(),
                          BlocBuilder<AddAddressBloc, AddAddressState>(
                            builder: (context, state) {
                              return state.formStatus is FormSubmitting
                                  ? CustomProgressIndicator()
                                  : DefaultButton(
                                      text: "Save",
                                      action: () {
                                        if (_formKey.currentState.validate()) {
                                          context
                                              .read<AddAddressBloc>()
                                              .add(AddAddressSubmitted());
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
    );
  }
}
