import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/authentication/authentication/session_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocListener<SessionCubit, SessionState>(
      listener: (context, state) {
        if (state == SessionState.Authenticated) {
          Navigator.pushReplacementNamed(context, '/explore');
        } else if (state == SessionState.UnAuthenticated) {
          Navigator.pushReplacementNamed(context, '/login');

        }else if (state == SessionState.SelectLocationAndShop) {
          Navigator.pushReplacementNamed(context, '/myLocation');

        }
      },
      child: Container(
        color: AppColors.PrimaryBase,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/app_logo.svg',
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
