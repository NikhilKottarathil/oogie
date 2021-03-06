import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';
import 'package:oogie/components/ui_widgets/custom_text_button_4.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/user_model.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_bloc.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_view.dart';
import 'package:oogie/screens/profile/edit_profile/edit_profile_view.dart';
import 'package:oogie/screens/profile/profile/profile_bloc.dart';
import 'package:oogie/screens/profile/profile/profile_events.dart';
import 'package:oogie/screens/profile/profile/profile_state.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarBlue(context: context, text: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * .1,
                          backgroundImage: NetworkImage(state.imageUrl),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.name,
                              style: TextStyles.mediumRegular,
                            ),
                            Text(
                              state.phoneNumber,
                              style: TextStyles.smallRegularSubdued,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  dividerDefault,
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'General',
                          style: TextStyles.smallRegularSubdued,
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        // if(FlavorConfig().flavorName != 'vendor' &&
                        //     FlavorConfig().flavorName !='wholesale_dealer')
                        CustomTextButton4(
                          text: 'Edit Profile Picture',
                          action: () {
                            context
                                .read<ProfileBloc>()
                                .add(ChangeProfilePicture(context: context));
                          },
                        ),
                        dividerDefault,
                        CustomTextButton4(
                          text: 'Edit Profile',
                          action: () {
                            if (FlavorConfig().flavorName == 'vendor' ||
                                FlavorConfig().flavorName ==
                                    'wholesale_dealer') {
                              print('--${FlavorConfig().flavorName}--');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => AddConnectionAgentBloc(
                                      vendorRepository: vendorRepository,
                                      wholeSaleRepository: wholeSaleRepository,
                                      userModel: UserModel(
                                          id: AppData().userId,
                                          userType:
                                              FlavorConfig().flavorName),
                                    ),
                                    child: AddConnectionAgentView(),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ProfileBloc>(),
                                    child: EditProfileView(),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        dividerDefault,
                        CustomTextButton4(
                          text: 'Manage Password',
                          action: () {
                            Navigator.pushNamed(context, '/resetPassword');
                          },
                        ),
                        dividerDefault,
                        Visibility(
                            visible: FlavorConfig().flavorName == 'user',
                            child: Column(
                              children: [
                                CustomTextButton4(
                                  text: 'Manage Address',
                                  action: () {
                                    Navigator.pushNamed(context, '/addressList',
                                        arguments: {'parentPage': 'profile'});
                                  },
                                ),
                                dividerDefault,
                              ],
                            )),
                        CustomTextButton4(
                          text: 'Manage Payment',
                        ),
                        dividerDefault,
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
