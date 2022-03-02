import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/screens/common/authentication/authentication/session_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocListener<SessionCubit, SessionState>(
      listener: (context, state) {
        if (FlavorConfig().flavorName == 'user') {
          if (state == SessionState.Authenticated) {
            Navigator.pushReplacementNamed(context, '/explore');
          } else if (state == SessionState.UnAuthenticated) {
            Navigator.pushReplacementNamed(context, '/myLocation');
          } else if (state == SessionState.SelectLocationAndShop) {
            Navigator.pushReplacementNamed(context, '/myLocation');
          }
        } else {
          if (state == SessionState.Authenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            Navigator.pushReplacementNamed(context, '/login');
          }
        }
      },
      child: Container(
        color: AppColors.PrimaryBase,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (FlavorConfig().flavorName == 'user')
                SvgPicture.asset(
                  'assets/app_logo.svg',
                  fit: BoxFit.cover,
                  height: height * .08,
                ),
              if (FlavorConfig().flavorName == 'vendor')
                Image.asset(
                  'assets/vendor_white.png',
                  fit: BoxFit.cover,
                  height: height * .08,
                ),
              if (FlavorConfig().flavorName == 'wholesale_dealer')
                Image.asset(
                  'assets/wholesale_white.png',
                  fit: BoxFit.cover,
                  height: height * .08,
                ),
              if (FlavorConfig().flavorName == 'distributor')
                Image.asset(
                  'assets/distributor_white.png',
                  fit: BoxFit.cover,
                  height: height * .08,
                ),
              if (FlavorConfig().flavorName == 'sales_executive')
                Image.asset(
                  'assets/sales_executive_white.png',
                  fit: BoxFit.cover,
                  height: height * .08,
                ),
              if (FlavorConfig().flavorName == 'delivery_partner')
                Image.asset(
                  'assets/delivery_partner_white.png',
                  fit: BoxFit.cover,
                  height: height * .08,
                ),
              SizedBox(
                height: height * .08,
              )
            ],
          ),
        ),
      ),
    );
  }
}
