import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/review_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_bloc.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_event.dart';
import 'package:oogie/screens/explore/review/review_list/review_list_state.dart';

class ReviewListView extends StatefulWidget {
  @override
  _ReviewListViewState createState() => _ReviewListViewState();
}

class _ReviewListViewState extends State<ReviewListView> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ReviewListBloc>().add(FetchMoreData());
      }
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'All Reviews'),
      body: BlocListener<ReviewListBloc, ReviewListState>(
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
        child: BlocBuilder<ReviewListBloc, ReviewListState>(
            builder: (context, state) {
          print(state.reviewModels.length);

          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.reviewModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ReviewAdapter(
                          reviewModel: state.reviewModels[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20,
                      );
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
