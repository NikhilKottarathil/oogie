import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_bloc.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_event.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_satate.dart';

class SelectLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddConnectionAgentBloc, AddConnectionAgentState>(
        listener: (context, state) {},
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              Text(
                'Select Shop Location',
                style: TextStyles.largeRegular,
              ),
              SizedBox(
                height: 4,
              ),
              // Text(
              //   'Select a region to showcase shops around it.',
              //   style: TextStyles.smallRegularSubdued,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       'If your region is not listed.',
              //       style: TextStyles.smallRegularSubdued,
              //     ),
              //     CustomTextButton2(
              //       text: 'Explore',
              //       action: () {},
              //     ),
              //   ],
              // ),
              BlocBuilder<AddConnectionAgentBloc, AddConnectionAgentState>(
                  builder: (context, state) {
                return CustomTextField2(
                  validator: (value) {
                    return null;
                  },
                  text: state.searchString,
                  onChange: (value) {
                    context.read<AddConnectionAgentBloc>().add(
                          SearchLocationChanged(searchString: value),
                        );
                  },
                  hintText: 'Search by Cities/Regions',
                  prefixIcon: 'icons/search.svg',
                );
              }),
              BlocBuilder<AddConnectionAgentBloc, AddConnectionAgentState>(
                builder: (context, state) {
                  return Flexible(
                    child: ListView.separated(
                      itemCount: state.locationModels.length,
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<AddConnectionAgentBloc>()
                                .add(LocationSelected(index: index));
                          },
                          child: Container(
                            decoration: new BoxDecoration(
                              color: AppColors.White,
                              border: new Border.all(
                                  color: locationModels[index].isSelected
                                      ? AppColors.PrimaryLight
                                      : AppColors.BorderDefault),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(8.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'icons/location.svg',
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    state.locationModels[index].name,
                                    style: TextStyles.smallRegular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    ),
                  );
                },
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
                                        state.locationModels.forEach((element) {
                                          if (element.isSelected) {
                                            isShopSelected = true;
                                          }
                                        });
                                        if (isShopSelected) {
                                          context
                                              .read<AddConnectionAgentBloc>()
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
                          state.index == 2
                              ? Expanded(
                                  child: TextButton(
                                      child: Text(
                                        'Submit',
                                        style: TextStyles.mediumMediumWhite,
                                      ),
                                      onPressed: () {
                                        bool isShopSelected = false;
                                        state.locationModels.forEach((element) {
                                          if (element.isSelected) {
                                            isShopSelected = true;
                                          }
                                        });
                                        if (isShopSelected) {
                                          context
                                              .read<AddConnectionAgentBloc>()
                                              .add(
                                                  AddConnectionAgentSubmitted());
                                        }
                                      }),
                                )
                              : Expanded(
                                  child: TextButton(
                                      child: Text(
                                        'Next',
                                        style: TextStyles.mediumMediumWhite,
                                      ),
                                      onPressed: () {}),
                                )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
