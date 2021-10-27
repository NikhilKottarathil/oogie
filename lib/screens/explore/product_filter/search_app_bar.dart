import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_bloc.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_event.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_state.dart';

showSearchAppBar({BuildContext buildContext}) async {
  TextEditingController textEditingController = TextEditingController();
  // textEditingController.text = buildContext.read<ProductFilterBloc>().state.searchString;

  await showDialog(
    context: buildContext,
    useSafeArea: false,
    barrierColor: Colors.transparent,
    builder: (context) => BlocProvider.value(
      value: buildContext.read<ProductFilterBloc>(),
      child: BlocBuilder<ProductFilterBloc, ProductFilterState>(
        builder: (context, state) {
          if (state.searchString == '') {
            textEditingController.text = '';
          }
          return AppBar(
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(top: 6.0, bottom: 6),
              child: Material(
                color: AppColors.White,
                borderRadius: BorderRadius.circular(8),
                child: TextFormField(
                  maxLines: 1,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value) {
                    context.read<ProductFilterBloc>().add(SearchSubmitted());
                    Navigator.pop(context);
                    print('saved $value');
                  },
                  controller: textEditingController,
                  onChanged: (text) {
                    context
                        .read<ProductFilterBloc>()
                        .add(SearchTextChanged(searchString: text));
                  },
                  style: TextStyles.smallRegular,
                  decoration: new InputDecoration(
                    hintText: 'Search for mobiles and accessories',
                    fillColor: Colors.white,

                    contentPadding: EdgeInsets.all(10),
                    suffixIcon: state.searchString.trim() == ''
                        ? null
                        : IconButton(
                            onPressed: () {
                              context
                                  .read<ProductFilterBloc>()
                                  .add(SearchTextChanged(searchString: ''));
                            },
                            icon: Icon(
                              Icons.close,
                              color: AppColors.OutlinedIcon,
                              size: 25,
                            ),
                          ),
                    hintStyle: TextStyles.smallRegularSubdued,
                    prefixIcon: SvgPicture.asset(
                      'icons/search.svg',
                      color: AppColors.TextDefault,
                      fit: BoxFit.scaleDown,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.BorderDefault, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),

                    enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(
                            color: AppColors.BorderDisabled, width: 1.0)),
                    //fillColor: Colors.green
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
