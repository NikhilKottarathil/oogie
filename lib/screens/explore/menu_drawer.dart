import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/components/icon_text_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/repository/auth_repo.dart';
import 'package:oogie/repository/profile_repository.dart';
import 'package:oogie/screens/user/orders/order_list.dart';
import 'package:oogie/screens/profile/profile/profile_bloc.dart';
import 'package:oogie/screens/profile/profile/profile_state.dart';

class MenuDrawer extends StatelessWidget {
  ProfileRepository profileRepository = ProfileRepository();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => ProfileBloc(profileRepository: profileRepository),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        child: Drawer(
          elevation: 10,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: AppColors.PrimaryBase,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/yellow_bar.svg',
                            height: 32,
                            width: 32,
                          ),
                          Spacer(),
                          Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.White,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                // color: Colors.green,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(state.imageUrl),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Hello, ${state.name}",
                                style: TextStyles.mediumRegularWhite,
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                    visible: FlavorConfig().flavorName == 'user',
                    child: Column(
                      children: [
                        IconTextButton(
                          iconUrl: 'icons/order.svg',
                          text: 'Orders',
                          action: () {
                            Navigator.of(context).pushNamed('/myOrders',
                                arguments: {'parentPage': 'menuDrawer'});
                          },
                        ),
                        IconTextButton(
                          iconUrl: 'icons/favourite.svg',
                          text: 'Wishlist',
                          action: () {
                            Navigator.of(context).pushNamed('/wishlist');
                          },
                        ),
                        // IconTextButton(
                        //   iconUrl: 'icons/location.svg',
                        //   text: 'Stores',
                        //   action: () {
                        //     Navigator.pushNamed(context, '/myLocation');
                        //   },
                        // ),
                        IconTextButton(
                          iconUrl: 'icons/smartphone.svg',
                          text: 'My Used Phones',
                          action: () {
                            // nonUsers Homepage is used Used Phones Section
                            Navigator.pushNamed(context, '/home');
                          },
                        ),
                      ],
                    )),
                IconTextButton(
                    iconUrl: 'icons/user.svg',
                    text: 'Profile',
                    action: () {
                      Navigator.pushNamed(context, '/profile');
                    }),
                IconTextButton(
                    iconUrl: 'icons/settings.svg',
                    text: 'Settings',
                    action: () {}),
                Spacer(),
                IconTextButton(
                    iconUrl: 'icons/logout.svg',
                    text: 'Logout',
                    action: () async {
                      AuthRepository authRepo = AuthRepository();
                      await authRepo.logOut();
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
