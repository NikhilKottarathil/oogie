import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/profile/my_location/my_location_bloc.dart';
import 'package:oogie/screens/profile/my_location/my_location_event.dart';
import 'package:oogie/screens/profile/my_location/my_location_state.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_bloc.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_view.dart';

class MyLocationView extends StatelessWidget {
  const MyLocationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(
          context: context, text: 'Location', prefixWidget: Container()),
      body: BlocListener<MyLocationBloc, MyLocationState>(
        listener: (context, state) {
          if (state.formStatus is SubmissionSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) =>
                        SelectShopBloc(profileRepository: context.read<MyLocationBloc>().profileRepository,locationModel: state.selectedLocation),
                    child: SelectShopView(),
                  ),
                ),);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              Text(
                'Update Your Location',
                style: TextStyles.largeRegular,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Select a region to showcase shops around it.',
                style: TextStyles.smallRegularSubdued,
              ),
              Row(
                children: [
                  Text(
                    'If your region is not listed.',
                    style: TextStyles.smallRegularSubdued,
                  ),
                  CustomTextButton2(
                    text: 'Explore',
                    action: () {},
                  ),
                ],
              ),
              BlocBuilder<MyLocationBloc, MyLocationState>(
                  builder: (context, state) {
                return CustomTextField2(
                  validator: (value) {
                    return null;
                  },
                  text: state.searchString,
                  onChange: (value) {
                    context.read<MyLocationBloc>().add(
                          SearchLocationChanged(searchString: value),
                        );
                  },
                  hintText: 'Search by Cities/Regions',
                  prefixIcon: 'icons/search.svg',
                );
              }),
              BlocBuilder<MyLocationBloc, MyLocationState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.locationModels.length,
                        padding: EdgeInsets.only(top: 16, bottom: 16),

                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context.read<MyLocationBloc>().add(
                                  MyLocationSelected(
                                      myLocation: state.locationModels[index]));
                            },
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
                          );
                        }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
