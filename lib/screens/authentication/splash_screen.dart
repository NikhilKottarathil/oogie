import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/screens/authentication/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    _isSignedIN();
    return Container(
      color: AppColors.PrimaryBase,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/app_logo.svg',fit: BoxFit.cover,height: height*.08,),
            SizedBox(height: height*.08,)
          ],
        ),
      ),
    );

  }
  void _isSignedIN() async {
    bool isSuccessful = true;
    // bool isSuccessful = await setBusinessData(context);
    if (isSuccessful) {
      await Future.delayed(Duration(seconds: 3));

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));

    }
  }

}
