import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/vertical_product_adapter.dart';
import 'package:oogie/components/app_bar/teritiary_app_bar.dart';
import 'package:oogie/components/custom_progress_indicator.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/explore/product_filter/filter_and_sort.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_bloc.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_event.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_state.dart';

class ProductFilterView extends StatefulWidget {
  @override
  _ProductFilterViewState createState() => _ProductFilterViewState();
}

class _ProductFilterViewState extends State<ProductFilterView> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ProductFilterBloc>().add(FetchMoreData());
      }
    });
    // if( context.read<ProductFilterBloc>().state.titleText=='search'){
    //   showSearchAppBar(buildContext: context);
    // }

  }


  @override
  Widget build(BuildContext buildContext) {
    print('flilter buildinggg 111');

    return Scaffold(
      appBar: teritiaryAppBar(buildContext: context,title: context.read<ProductFilterBloc>().state.titleText),
      body: BlocListener<ProductFilterBloc, ProductFilterState>(
        listener: (context, state) async {
          if (state.pageScrollStatus is ScrollToTopStatus) {
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              scrollController.animateTo(
                  scrollController.position.minScrollExtent,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn);
            });
          }
          Exception e = state.actionErrorMessage;
          if (e != null && e.toString().length != 0) {
            showSnackBar(context, e);
          }
        },
        child: BlocBuilder<ProductFilterBloc, ProductFilterState>(
            builder: (context, state) {
          print(state.productModels.length);

          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12,bottom: 12,left: 20,right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Search Results:',
                        style: TextStyles.displayMedium,
                      ),
                      InkWell(
                        onTap: (){
                          filterAndSort(buildContext: context);
                          FocusScopeNode currentFocus =
                          FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: AppColors.BorderDefault),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              SvgPicture.asset('icons/filter.svg'),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Filter',
                                style: TextStyles.smallMedium,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.productModels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return VerticalProductAdapter(
                        state.productModels[index]);
                  },
                ),
                state.isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomProgressIndicator(),
                      )
                    : Container(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
