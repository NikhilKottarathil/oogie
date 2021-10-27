import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/shop_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_bloc.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_event.dart';
import 'package:oogie/screens/profile/select_shop/select_shop_state.dart';

class SelectShopView extends StatelessWidget {
  const SelectShopView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(
          text: context.read<SelectShopBloc>().locationModel.name,
          context: context),
      body: BlocListener<SelectShopBloc, SelectShopState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            showSnackBar(context, formStatus.exception);
          } else if (formStatus is SubmissionSuccess) {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/explore');
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
                'Select A Shop To Explore',
                style: TextStyles.largeRegular,
              ),
              BlocBuilder<SelectShopBloc, SelectShopState>(
                  builder: (context, state) {
                return CustomTextField2(
                  validator: (value) {
                    return null;
                  },
                  text: state.searchString,
                  onChange: (value) {
                    context.read<SelectShopBloc>().add(
                          SearchShopChanged(searchString: value),
                        );
                  },
                  hintText: 'Search Shop',
                  prefixIcon: 'icons/search.svg',
                );
              }),
              BlocBuilder<SelectShopBloc, SelectShopState>(
                builder: (context, state) {
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: .75,
                            crossAxisCount: 2),
                        itemCount: state.shopModels.length,
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context.read<SelectShopBloc>().add(
                                  ShopSelected(shop: state.shopModels[index]));
                            },
                            child: ShopAdapter(
                              shopModel: state.shopModels[index],
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
