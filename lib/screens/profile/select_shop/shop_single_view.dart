import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/alert_bottom_sheet.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/shop_model.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_bloc.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_event.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_state.dart';

class ShopSingleView extends StatelessWidget {
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Select Shop'),
      body: BlocListener<SelectShopBloc, SelectShopState>(
        listener: (context, state) async {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            showSnackBar(context, formStatus.exception);
          } else if (formStatus is SubmissionSuccess) {
            if (context.read<SelectShopBloc>().parentPage == 'dynamicLink') {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed( '/explore');

            }
          }
        },
        child: BlocBuilder<SelectShopBloc, SelectShopState>(
          builder: (context,state) {
            if( context.read<SelectShopBloc>().selectedShopModel!=null) {
              return Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    children: [
                      context
                          .read<SelectShopBloc>()
                          .selectedShopModel
                          .imageUrl != null
                          ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            context
                                .read<SelectShopBloc>()
                                .selectedShopModel
                                .imageUrl,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                          ))
                          : Expanded(
                          child: Center(
                              child: Image.asset('refAssets/store_icon.png'))),
                      SizedBox(
                        height: 20,
                      ),

                      Text(
                        context
                            .read<SelectShopBloc>()
                            .selectedShopModel
                            .name,
                        style: TextStyles.largeMedium,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        context
                            .read<SelectShopBloc>()
                            .selectedShopModel
                            .caption,
                        style: TextStyles.mediumRegular,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Text(
                        context
                            .read<SelectShopBloc>()
                            .selectedShopModel
                            .description,
                        style: TextStyles.smallRegular,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Text(
                        'Address',
                        style: TextStyles.mediumMedium,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_pin),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    context
                                        .read<SelectShopBloc>()
                                        .selectedShopModel
                                        .address,
                                    style: TextStyles.smallRegular,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.timer),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    context
                                        .read<SelectShopBloc>()
                                        .selectedShopModel
                                        .workingTime,
                                    style: TextStyles.smallRegular,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.today_sharp),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    context
                                        .read<SelectShopBloc>()
                                        .selectedShopModel
                                        .workingDays,
                                    style: TextStyles.smallRegular,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    context
                                        .read<SelectShopBloc>()
                                        .selectedShopModel
                                        .phoneNumber,
                                    style: TextStyles.smallRegular,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.email),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    context
                                        .read<SelectShopBloc>()
                                        .selectedShopModel
                                        .email,
                                    style: TextStyles.smallRegular,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 100,
                      )
                      // Spacer(),
                      // Icon(Icons.arrow_forward_ios_sharp,color: AppColors.OutlinedIcon,),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: DefaultButton(
                          text: 'Select Shop',
                          action: () {
                            showAlertBottomSheet(
                                context: context,
                                content: 'Are sure to ${ context
                                    .read<SelectShopBloc>()
                                    .selectedShopModel
                                    .name} select shop as default shop ?',
                                positiveText: 'CONFIRM',
                                positiveAction: () {
                                  context.read<SelectShopBloc>().add(
                                      ShopSelectedSubmitted(
                                          shop: context
                                              .read<SelectShopBloc>()
                                              .selectedShopModel,
                                          isUsedPhonesSelected: false));
                                  Navigator.of(context).pop();
                                });
                          }),
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
        ),
      ),
    );
  }
}
