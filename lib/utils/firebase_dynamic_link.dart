import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/main_common.dart';
import 'package:oogie/models/location_model.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_bloc.dart';
import 'package:oogie/screens/profile/select_shop/shop_single_view.dart';
import 'package:share_plus/share_plus.dart';

FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

Future generateProductDynamicLink({String id}) {
  String queryParameters = 'linkType=product&id=$id';
  return generateDynamicLink(queryParameters: queryParameters);
}

Future generateShopDynamicLink({@required String shopId, @required String locationId,@required String locationName}) {
  String queryParameters =
      'linkType=shop&shopId=$shopId&locationId=$locationId&locationName=$locationName';
  return generateDynamicLink(queryParameters: queryParameters);
}

Future generateDynamicLink({String queryParameters}) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    // The Dynamic Link URI domain. You can view created URIs on your Firebase console
    uriPrefix: 'https://oogieshopee.page.link',
    // The deep Link passed to your application which you can use to affect change
    link: Uri.parse('https://oogieshopee.com?$queryParameters'),

    // Android application details needed for opening correct app on device/Play Store
    androidParameters: const AndroidParameters(
      packageName: 'com.hamrut.oogie.user',
      minimumVersion: 1,
    ),
    // iOS application details needed for opening correct app on device/App Store
    // iosParameters: const IOSParameters(
    //   bundleId: iosBundleId,
    //   minimumVersion: '2',
    // ),
  );

  final Uri uri = await dynamicLinks.buildLink(parameters);
  Share.share(uri.toString());
}

listenDynamicLink(BuildContext context) async {
  PendingDynamicLinkData data;
  if (Platform.isIOS) {
    await Future.delayed(Duration(seconds: 2), () async {
      data = await FirebaseDynamicLinks.instance.getInitialLink();
      if (data != null) dynamicLinkAction(queryParameters: data.link.queryParameters,delayDuration: 3);
    });
  } else {
    data = await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) dynamicLinkAction(queryParameters: data.link.queryParameters,delayDuration: 3);
  }
  print('DynamicLinks   $data');
  FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
    print('DynamicLinks data  ${dynamicLinkData.link.queryParameters}');
    Map<String, String> queryParameters = dynamicLinkData.link.queryParameters;

    dynamicLinkAction(delayDuration: 0,queryParameters: queryParameters);
  }).onError((error) {
    // Handle errors
    print('DynamicLinks error $error');
  });
}

dynamicLinkAction({Map<String, String> queryParameters,int delayDuration}) async {
  if (queryParameters['linkType'] == 'product') {
    Navigator.pushNamed(
      MyApp.navigatorKey.currentContext,
      '/product',
      arguments: {'parentPage': 'dynamicLink', 'id': queryParameters['id']},
    );
  } else {
    await Future.delayed(Duration(seconds: delayDuration));
    Navigator.push(
      MyApp.navigatorKey.currentContext,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => SelectShopBloc(
              profileRepository: profileRepository,
              locationModel: LocationModel(
                id: queryParameters['locationId'],
                isSelected: true,
                name: queryParameters['locationName'],
              ),
              parentPage: 'dynamicLink',
              shopId: queryParameters['shopId']),
          child: ShopSingleView(),
        ),
      ),
    );
  }
}
