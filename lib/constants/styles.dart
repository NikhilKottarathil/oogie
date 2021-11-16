import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color BackgroundColor = const Color(0xFFFFFFFF);

  static const Color InkLighter = const Color(0xFF72777A);
  static const Color InkLight = const Color(0xFF6C7072);
  static const Color InkBase = const Color(0xFF404446);
  static const Color InkDark = const Color(0xFF303437);
  static const Color InkDarker = const Color(0xFF202325);
  static const Color InkDarkest = const Color(0xFF090A0A);

  static const Color SkyLightest = const Color(0xFFF7F9FA);
  static const Color SkyLighter = const Color(0xFFF2F4F5);
  static const Color SkyLight = const Color(0xFFE3E5E5);
  static const Color SkyBase = const Color(0xFFCDCFD0);
  static const Color SkyDark = const Color(0xFF979A9E);

  static const Color PrimaryLightest = const Color(0xFFC8FFFF);
  static const Color PrimaryLighter = const Color(0xFFA0EBFF);
  static const Color PrimaryLight = const Color(0xFF509BFF);
  static const Color PrimaryBase = const Color(0xFF2873F0);
  static const Color PrimaryDark = const Color(0xFF145FDC);

  static const Color SecondaryLightest = const Color(0xFFFFFF95);
  static const Color SecondaryLighter = const Color(0xFFFFFF6D);
  static const Color SecondaryLight = const Color(0xFFFFE41D);
  static const Color SecondaryBase = const Color(0xFFF8D009);
  static const Color SecondaryDark = const Color(0xFFE4BC00);

  static const Color GreenLightest = const Color(0xFFECFCE5);
  static const Color GreenLighter = const Color(0xFF7DDE86);
  static const Color GreenLight = const Color(0xFF4CD471);
  static const Color GreenBase = const Color(0xFF23C16B);
  static const Color GreenDark = const Color(0xFF198155);

  static const Color YellowLightest = const Color(0xFFFFEFD7);
  static const Color YellowLighter = const Color(0xFFFFD188);
  static const Color YellowLight = const Color(0xFFFFC462);
  static const Color YellowBase = const Color(0xFFFFB323);
  static const Color YellowDark = const Color(0xFFA05E03);

  static const Color CriticalLightest = const Color(0xFFFFE5E5);
  static const Color CriticalLighter = const Color(0xFFFF9898);
  static const Color CriticalLight = const Color(0xFFFF6D6D);
  static const Color CriticalBase = const Color(0xFFFF5247);
  static const Color CriticalDark = const Color(0xFFD3180C);

  static const Color Grey = const Color(0xFFBABABA);
  static const Color Grey1Text = const Color(0xFF333333);

  static const Color BorderDefault = const Color(0xFFCDCFD0);
  static const Color BorderDisabled = const Color(0xFFE3E5E5);

  static const Color TextDefault = const Color(0xFF404446);
  static const Color TextSubdued = const Color(0xFF6C7072);
  static const Color White = const Color(0xFFFFFFFF);

  static const Color SolidIcon = const Color(0xFFF7F9FA);
  static const Color OutlinedIcon = const Color(0xFF404446);

  static const Color DividerBase = const Color(0xFFF2F4F5);
  static const Color SurfaceDisabled = const Color(0xFFF7F9FA);

  static Color ShadowColor = Color(0xFF141414).withOpacity(.08);
}

class AppBorders {
  static const OutlineInputBorder transparentBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent));
}

class TextStyles {
  static const TextStyle tinyRegular = const TextStyle(
      fontSize: 11,
      color: AppColors.TextDefault,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle tinyMedium = const TextStyle(
      fontSize: 11,
      color: AppColors.TextDefault,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle tinyBold = const TextStyle(
      fontSize: 11,
      color: AppColors.TextDefault,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle smallRegular = const TextStyle(
      fontSize: 14,
      color: AppColors.TextDefault,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle smallMedium = const TextStyle(
      fontSize: 14,
      color: AppColors.TextDefault,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle smallBold = const TextStyle(
      fontSize: 14,
      color: AppColors.TextDefault,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle mediumRegular = const TextStyle(
      fontSize: 18,
      color: AppColors.TextDefault,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle mediumMedium = const TextStyle(
      fontSize: 18,
      color: AppColors.TextDefault,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle mediumBold = const TextStyle(
      fontSize: 18,
      color: AppColors.TextDefault,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle largeRegular = const TextStyle(
      fontSize: 24,
      color: AppColors.TextDefault,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle largeMedium = const TextStyle(
      fontSize: 24,
      color: AppColors.TextDefault,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle largeBold = const TextStyle(
      fontSize: 24,
      color: AppColors.TextDefault,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle display = const TextStyle(
      fontSize: 32,
      color: AppColors.TextDefault,
      height: 1.33,
      fontFamily: 'DMSerifDisplay',
      fontWeight: FontWeight.w400);
  static const TextStyle displayMedium = const TextStyle(
      fontSize: 24,
      color: AppColors.TextDefault,
      height: 1.33,
      fontFamily: 'DMSerifDisplay',
      fontWeight: FontWeight.w400);

  static const TextStyle tinyRegularSubdued = const TextStyle(
      fontSize: 11,
      color: AppColors.TextSubdued,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle tinyMediumSubdued = const TextStyle(
      fontSize: 11,
      color: AppColors.TextSubdued,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle tinyBoldSubdued = const TextStyle(
      fontSize: 11,
      color: AppColors.TextSubdued,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle smallRegularSubdued = const TextStyle(
      fontSize: 14,
      color: AppColors.TextSubdued,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle smallMediumSubdued = const TextStyle(
      fontSize: 14,
      color: AppColors.TextSubdued,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle smallBoldSubdued = const TextStyle(
      fontSize: 14,
      color: AppColors.TextSubdued,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle mediumRegularSubdued = const TextStyle(
      fontSize: 18,
      color: AppColors.TextSubdued,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle mediumMediumSubdued = const TextStyle(
      fontSize: 18,
      color: AppColors.TextSubdued,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle mediumBoldSubdued = const TextStyle(
      fontSize: 18,
      color: AppColors.TextSubdued,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle largeRegularSubdued = const TextStyle(
      fontSize: 24,
      color: AppColors.TextSubdued,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle largeMediumSubdued = const TextStyle(
      fontSize: 24,
      color: AppColors.TextSubdued,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle largeBoldSubdued = const TextStyle(
      fontSize: 24,
      color: AppColors.TextSubdued,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle displayMediumSubdued = const TextStyle(
      fontSize: 24,
      color: AppColors.TextSubdued,
      height: 1.33,
      fontFamily: 'DMSerifDisplay',
      fontWeight: FontWeight.w400);
  static const TextStyle displaySubdued = const TextStyle(
      fontSize: 32,
      color: AppColors.TextSubdued,
      height: 1.33,
      fontFamily: 'DMSerifDisplay',
      fontWeight: FontWeight.w400);

  static const TextStyle tinyRegularPrimaryLight = const TextStyle(
      fontSize: 11,
      color: AppColors.PrimaryLight,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle tinyMediumPrimaryLight = const TextStyle(
      fontSize: 11,
      color: AppColors.PrimaryLight,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle tinyBoldPrimaryLight = const TextStyle(
      fontSize: 11,
      color: AppColors.PrimaryLight,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle smallRegularPrimaryLight = const TextStyle(
      fontSize: 14,
      color: AppColors.PrimaryLight,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle smallMediumPrimaryLight = const TextStyle(
      fontSize: 14,
      color: AppColors.PrimaryLight,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle smallBoldPrimaryLight = const TextStyle(
      fontSize: 14,
      color: AppColors.PrimaryLight,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle mediumRegularPrimaryLight = const TextStyle(
      fontSize: 18,
      color: AppColors.PrimaryLight,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle mediumMediumPrimaryLight = const TextStyle(
      fontSize: 18,
      color: AppColors.PrimaryLight,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle mediumBoldPrimaryLight = const TextStyle(
      fontSize: 18,
      color: AppColors.PrimaryLight,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle largeRegularPrimaryLight = const TextStyle(
      fontSize: 24,
      color: AppColors.PrimaryLight,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle largeMediumPrimaryLight = const TextStyle(
      fontSize: 24,
      color: AppColors.PrimaryLight,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle largeBoldPrimaryLight = const TextStyle(
      fontSize: 24,
      color: AppColors.PrimaryLight,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle displayPrimaryLight = const TextStyle(
      fontSize: 32,
      color: AppColors.PrimaryLight,
      height: 1.33,
      fontFamily: 'DMSerifDisplay',
      fontWeight: FontWeight.w400);
  static const TextStyle displayMediumPrimaryLight = const TextStyle(
      fontSize: 24,
      color: AppColors.PrimaryLight,
      height: 1.33,
      fontFamily: 'DMSerifDisplay',
      fontWeight: FontWeight.w400);

  static const TextStyle tinyRegularWhite = const TextStyle(
      fontSize: 11,
      color: AppColors.White,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle tinyMediumWhite = const TextStyle(
      fontSize: 11,
      color: AppColors.White,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle tinyBoldWhite = const TextStyle(
      fontSize: 11,
      color: AppColors.White,
      height: 1.1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle smallRegularWhite = const TextStyle(
      fontSize: 14,
      color: AppColors.White,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle smallMediumWhite = const TextStyle(
      fontSize: 14,
      color: AppColors.White,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle smallBoldWhite = const TextStyle(
      fontSize: 14,
      color: AppColors.White,
      height: 1.43,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle mediumRegularWhite = const TextStyle(
      fontSize: 18,
      color: AppColors.White,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle mediumMediumWhite = const TextStyle(
      fontSize: 18,
      color: AppColors.White,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle mediumBoldWhite = const TextStyle(
      fontSize: 18,
      color: AppColors.White,
      height: 1,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle largeRegularWhite = const TextStyle(
      fontSize: 24,
      color: AppColors.White,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w400);
  static const TextStyle largeMediumWhite = const TextStyle(
      fontSize: 24,
      color: AppColors.White,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w500);
  static const TextStyle largeBoldWhite = const TextStyle(
      fontSize: 24,
      color: AppColors.White,
      height: 1.33,
      fontFamily: 'DMSans',
      fontWeight: FontWeight.w700);

  static const TextStyle displayWhite = const TextStyle(
      fontSize: 32,
      color: AppColors.White,
      height: 1.33,
      fontFamily: 'DMSerifDisplay',
      fontWeight: FontWeight.w400);
  static const TextStyle displayMediumWhite = const TextStyle(
      fontSize: 24,
      color: AppColors.White,
      height: 1.33,
      fontFamily: 'DMSerifDisplay',
      fontWeight: FontWeight.w400);
}

const edgePadding = const EdgeInsets.all(20);
const dividerDefault = const Divider(
  thickness: 1,
  color: AppColors.DividerBase,
);const dividerDefault2 = const Divider(
  thickness: 0.1,
  color:  AppColors.InkLighter,
);
const rupeesString = '\u{20B9}';

class AppShadows {
  static List<BoxShadow> shadowSmall = [
    BoxShadow(
        color: Color(0xFF141414).withOpacity(.08),
        offset: Offset(0, 0),
        blurRadius: 8,
        spreadRadius: 0),
    BoxShadow(
        color: Color(0xFF141414).withOpacity(.04),
        offset: Offset(0, 0),
        blurRadius: 1,
        spreadRadius: 0),
  ];

  static List<BoxShadow> shadowMedium = [
    BoxShadow(
        color: Color(0xFF141414).withOpacity(.08),
        offset: Offset(0, 1),
        blurRadius: 8,
        spreadRadius: 2),
    BoxShadow(
        color: Color(0xFF141414).withOpacity(.08),
        offset: Offset(0, 0),
        blurRadius: 1,
        spreadRadius: 0),
  ];

  static List<BoxShadow> shadowLarge = [
    BoxShadow(
        color: Color(0xFF141414).withOpacity(.08),
        offset: Offset(0, 1),
        blurRadius: 24,
        spreadRadius: 8),
    BoxShadow(
        color: Color(0xFF141414).withOpacity(.08),
        offset: Offset(0, 0),
        blurRadius: 1,
        spreadRadius: 0),
  ];

  static List<BoxShadow> shadowTiny = [
    BoxShadow(
        color: Color(0xFF323247).withOpacity(.05),
        offset: Offset(0, 2.51),
        blurRadius: 6.7,
        spreadRadius: -0.84),
    BoxShadow(
        color: Color(0xFF0C1A4B).withOpacity(.24),
        offset: Offset(0, 0),
        blurRadius: 0.84,
        spreadRadius: 0),
  ];
}
