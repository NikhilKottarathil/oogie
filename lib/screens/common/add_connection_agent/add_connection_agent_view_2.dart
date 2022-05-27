import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_bloc.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_event.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_satate.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';

class AddConnectionAgentView2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: BlocListener<AddConnectionAgentBloc, AddConnectionAgentState>(
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
                                    // BlocBuilder<AddConnectionAgentBloc,
                                    //     AddConnectionAgentState>(
                                    //   builder: (context, state) {
                                    //     return CustomTextField(
                                    //         hintText:
                                    //             "Working Days  (Required)",
                                    //         validator: (value) {
                                    //           return value.toString().length ==
                                    //                   0
                                    //               ? 'Please Fill'
                                    //               : null;
                                    //         },
                                    //         text: state.workingDays,
                                    //         onChange: (value) {
                                    //           context
                                    //               .read<
                                    //                   AddConnectionAgentBloc>()
                                    //               .add(
                                    //                 WorkingDaysChanged(
                                    //                     value: value),
                                    //               );
                                    //         },
                                    //         textInputType: TextInputType.text);
                                    //   },
                                    // ),
                                    Text('Select Working Days',style: TextStyles.smallMedium,),
                                    SizedBox(height: 10,),
                                    BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return Wrap(
                                          children: state.workingDays.map((e) { return GestureDetector(onTap:(){
                                            context
                                                .read<
                                                AddConnectionAgentBloc>()
                                                .add(
                                              WorkingDaysSelected(
                                                  value: e.value),
                                            );
                                          },child: KeyValueRadioItem(e));}).toList()
                                        );
                                      },
                                    ),
                                    BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText:
                                                "Opening Time  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.openingTime,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    OpeningTimeChanged(
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
                                                "Closing Time  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.closingTime,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    ClosingTimeChanged(
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
                                                "Building Name  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.buildingName,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    BuildingNameChanged(
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
                                                "Floor Door Number  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.floorDoorNumber,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    FloorDoorNumberChanged(
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
                                            hintText: "Street  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.streetName,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    StreetNameChanged(
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
                                            hintText: "Landmark  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.landmark,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    LandMarkChanged(
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
                                            hintText: "Pincode  (Required)",
                                            validator: (value) {
                                              return state
                                                  .pinCodeValidationText;
                                            },
                                            text: state.zipCode,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    ZipCodeChanged(
                                                        value: value),
                                                  );
                                            },
                                            textInputType:
                                                TextInputType.number);
                                      },
                                    ),
                                    BlocBuilder<AddConnectionAgentBloc,
                                        AddConnectionAgentState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                            hintText: "Province  (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.province,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    ProvinceChanged(
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
                                            hintText: "District (Required)",
                                            validator: (value) {
                                              return value.toString().length ==
                                                      0
                                                  ? 'Please Fill'
                                                  : null;
                                            },
                                            text: state.district,
                                            maxLines: 1,
                                            onChange: (value) {
                                              context
                                                  .read<
                                                      AddConnectionAgentBloc>()
                                                  .add(
                                                    DistrictChanged(
                                                        value: value),
                                                  );
                                            },
                                            textInputType: TextInputType.text);
                                      },
                                    ),
                                    SizedBox(
                                      height: 80,
                                    )
                                  ],
                                ),
                              ),
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
