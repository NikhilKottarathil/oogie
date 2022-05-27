import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_bloc.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_event.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_satate.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';

class AddConnectionAgentView1 extends StatefulWidget {
  @override
  State<AddConnectionAgentView1> createState() => _AddConnectionAgentView1State();
}

class _AddConnectionAgentView1State extends State<AddConnectionAgentView1> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: BlocListener<AddConnectionAgentBloc, AddConnectionAgentState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            showSnackBar(context, formStatus.exception);
          }
        },
        child: Material(
          child: Form(
            key: _formKey,
            child: LayoutBuilder(builder: (context, constraints) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if(context.read<AddConnectionAgentBloc>().isNew)
                                    Text('Select user type',style: TextStyles.smallRegular,),
                                    if(context.read<AddConnectionAgentBloc>().isNew)

                                      SizedBox(height:20,),
                                    if(context.read<AddConnectionAgentBloc>().isNew)

                                      BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return Wrap(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<AddConnectionAgentBloc>()
                                                    .add(
                                                      AgentTypeChanged(
                                                          value: 'vendor'),
                                                    );
                                              },
                                              splashColor: Colors.transparent,
                                              child: KeyValueRadioItem(
                                                  KeyValueRadioModel(
                                                      value: 'vendor',
                                                      key: 'Shop Owner',
                                                      isSelected: state.agentType ==
                                                          'vendor')),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                context
                                                    .read<AddConnectionAgentBloc>()
                                                    .add(
                                                      AgentTypeChanged(
                                                          value:
                                                              'wholesale_dealer'),
                                                    );
                                              },
                                              splashColor: Colors.transparent,
                                              child: KeyValueRadioItem(
                                                  KeyValueRadioModel(
                                                      value: 'wholesale_dealer',
                                                      key: 'WholeSale Dealer',
                                                      isSelected: state.agentType ==
                                                          'wholesale_dealer')),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                    BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText: "Name  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.name,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    NameChanged(value: value),
                                                  );
                                            },
                                            textInputType: TextInputType.text);
                                      },
                                    ),
                                    BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText: "Email  (Required)",
                                            validator: (value) {
                                              return state.emailValidationText;
                                            },
                                            text: state.email,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    EmailChanged(value: value),
                                                  );
                                            },
                                            textInputType: TextInputType.text);
                                      },
                                    ),
                                    if(context.read<AddConnectionAgentBloc>().isNew)

                                      BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText: "Mobile  (Required)",
                                            validator: (value) {
                                              return state.mobileValidationText;
                                            },
                                            text: state.mobile,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    MobileChanged(value: value),
                                                  );
                                            },
                                            textInputType:
                                                TextInputType.number);
                                      },
                                    ),
                                    if(context.read<AddConnectionAgentBloc>().isNew)

                                      BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText: "Password  (Required)",
                                            validator: (value) {
                                              return state
                                                  .passwordValidationText;
                                            },
                                            text: state.password,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    PasswordChanged(
                                                        value: value),
                                                  );
                                            },
                                            textInputType:
                                                TextInputType.visiblePassword);
                                      },
                                    ),
                                    BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText: "Caption  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.caption,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    NameChanged(value: value),
                                                  );
                                            },
                                            textInputType: TextInputType.text);
                                      },
                                    ),
                                    BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText:
                                                "About Description (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.aboutDescription,
                                            maxLines: 4,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    AboutDescriptionChanged(
                                                        value: value),
                                                  );
                                            },
                                            textInputType: TextInputType.text);
                                      },
                                    ),
                                    BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText:
                                                "Contact Person Name (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.contactPersonName,
                                            maxLines: 1,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    ContactPersonNameChanged(
                                                        value: value),
                                                  );
                                            },
                                            textInputType: TextInputType.text);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BlocBuilder<AddConnectionAgentBloc,
                        AddConnectionAgentState>(
                      builder: (context, state) {
                        return Container(
                          color: AppColors.PrimaryBase,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              state.index == 0
                                  ? Expanded(
                                      child: TextButton(
                                          child: Text(
                                            'Prev',
                                            style: TextStyle(
                                                color: Colors.transparent),
                                          ),
                                          onPressed: () {
                                            bool isShopSelected = false;
                                            state.locationModels
                                                .forEach((element) {
                                              if (element.isSelected) {
                                                isShopSelected = true;
                                              }
                                            });
                                            if (isShopSelected) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                      AddConnectionAgentSubmitted());
                                            }
                                          }),
                                    )
                                  : Expanded(
                                      child: TextButton(
                                        child: Text(
                                          'Prev',
                                          style: TextStyles.mediumMediumWhite,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<AddConnectionAgentBloc>()
                                              .add(PageChanged(
                                                  index: state.index - 1));
                                        },
                                      ),
                                    ),
                              state.index == 3
                                  ? Expanded(
                                      child: TextButton(
                                        child: Text(
                                          'Submit',
                                          style: TextStyles.mediumMediumWhite,
                                        ),
                                        onPressed: () {},
                                      ),
                                    )
                                  : Expanded(
                                      child: TextButton(
                                        child: Text(
                                          'Next',
                                          style: TextStyles.mediumMediumWhite,
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            context
                                                .read<AddConnectionAgentBloc>()
                                                .add(PageChanged(
                                                    index: state.index + 1));
                                          }
                                        },
                                      ),
                                    )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
