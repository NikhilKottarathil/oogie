import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/wishlist_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';

import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/wishlist/wishlist_bloc.dart';
import 'package:oogie/screens/wishlist/wishlist_event.dart';
import 'package:oogie/screens/wishlist/wishlist_state.dart';

class WishlistView extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: defaultAppBarBlue(context: buildContext,text: 'Wishlist'),
      body: BlocListener<WishlistBloc, WishlistState>(
        listener: (context, state) async {
          Exception e = state.actionErrorMessage;
          if (e != null && e.toString().length != 0) {
            showSnackBar(context, e);
          }
        },
        child: BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
          return  state.productModels.length == 0
                ? Center(
                child: Text(
                  'Your wishlist is empty',
                  style: TextStyles.mediumMediumSubdued,
                ))
                : ListView.separated(
            padding: EdgeInsets.all(20),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.productModels.length,
              itemBuilder: (BuildContext context, int index) {
                return WishlistAdapter(
                  
                  productModel: state.productModels[index],
                  deleteAction: () {
                    removeFromWishlist(
                        buildContext: context,
                        productModel:
                        state.productModels[index],
                        index: index,
                        );
                  },
                );
              },
              separatorBuilder:
                  (BuildContext context, int index) {
                return SizedBox(
                  height: 20,
                );
              },

          );
        }),
      ),
    );
  }
}

removeFromWishlist(
    {BuildContext buildContext,
    ProductModel productModel,
    int index,}) async {
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,
      useRootNavigator: true,
      isScrollControlled: false,
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(buildContext).size.height - 30,
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        return BlocProvider.value(
          value: buildContext.read<WishlistBloc>(),
          child: BlocBuilder<WishlistBloc, WishlistState>(builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: productModel.imageUrl != null
                                  ? Image.network(productModel.imageUrl,
                                      fit: BoxFit.scaleDown)
                                  : SvgPicture.asset(Urls().productImage,
                                      fit: BoxFit.scaleDown)),
                        ),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Remove from wishlist ?',
                            style: TextStyles.largeRegular,
                          ),
                          Text(
                            productModel.displayName,
                            style: TextStyles.smallRegularSubdued,
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.TextDefault,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultButton(

                    text: 'Remove',
                    action: () {
                      buildContext.read<WishlistBloc>().add(
                          RemoveProductFromWishlist(index: index));
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            );
          }),
        );
      });
}
