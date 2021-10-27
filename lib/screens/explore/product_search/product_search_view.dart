import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/vertical_product_adapter.dart';
import 'package:oogie/components/app_bar/secondary_app_bar.dart';
import 'package:oogie/components/custom_progress_indicator.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/explore/product_list/product_list_bloc.dart';
import 'package:oogie/screens/explore/product_list/product_list_event.dart';
import 'package:oogie/screens/explore/product_list/product_list_state.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ProductListBloc>().add(FetchMoreData());
      }
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: secondaryAppBar(context: context),
      body: BlocListener<ProductListBloc, ProductListState>(
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
        child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
          print(state.productModels.length);

          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.read<ProductListBloc>().parentPage,
                    style: TextStyles.displayMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15),
                    shrinkWrap: true,
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
            ),
          );
        }),
      ),
    );
  }
}
