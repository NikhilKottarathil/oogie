import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/product_by_creator_adapter.dart';
import 'package:oogie/adapters/vertical_product_adapter.dart';
import 'package:oogie/components/app_bar/secondary_app_bar.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/common/products/add_product/add_product_bloc.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_0.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_bloc.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_event.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_state.dart';

class ProductListByCreatorView extends StatefulWidget {
  @override
  _ProductListByCreatorViewState createState() =>
      _ProductListByCreatorViewState();
}

class _ProductListByCreatorViewState extends State<ProductListByCreatorView> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ProductListByCreatorBloc>().add(FetchMoreData());
      }
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: BlocListener<ProductListByCreatorBloc, ProductListByCreatorState>(
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
        child: BlocBuilder<ProductListByCreatorBloc, ProductListByCreatorState>(
            builder: (context, state) {
          print(state.productModels.length);

          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.productModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductByCreatorAdapter(state.productModels[index]);
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.PrimaryBase,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => AddProductBloc(
                    productIdOld: null,
                    productListByCreatorBloc: context
                        .read<ProductListByCreatorBloc>(),
                    productRepository: context
                        .read<ProductListByCreatorBloc>()
                        .productRepository,
                    parentPage: context.read<ProductListByCreatorBloc>().parentPage),
                child: AddProductView0(),
              ),
            ),
          );
        },
      ),
    );
  }
}
