import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/connection_agents_adapter.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_bloc.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_event.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_state.dart';

class ConnectionAgentsListView extends StatefulWidget {
  @override
  _ConnectionAgentsListViewState createState() =>
      _ConnectionAgentsListViewState();
}

class _ConnectionAgentsListViewState extends State<ConnectionAgentsListView> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ConnectionAgentsListBloc>().add(FetchMoreData());
      }
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: BlocListener<ConnectionAgentsListBloc, ConnectionAgentsListState>(
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
        child: BlocBuilder<ConnectionAgentsListBloc, ConnectionAgentsListState>(
            builder: (context, state) {
          print('buil;der ');
          print(state.models.length);

          return
              // SingleChildScrollView(
              //   controller: scrollController,
              //   child:
              Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wrap(
                //   children: List.generate(
                //       state.filterModels.length,
                //           (index) => InkWell(
                //           splashColor: Colors.transparent,
                //           onTap: () {
                //             context.read<ConnectionAgentsListBloc>().add(FilterItemSelected(index: index));
                //             // context.read<ConnectionAgentsListBloc>().add(FetchMoreData( ));
                //
                //           },
                //           child: KeyValueRadioItem(state.filterModels[index]))),
                // ),

                state.displayModels.length != 0
                    ? ListView.separated(
                        // physics: NeverScrollableScrollPhysics(),

                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.displayModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ConnectionAgentsAdapter(
                              userModel: state.displayModels[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 20,
                          );
                        },
                      )
                    : Expanded(
                        child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Vendors Yet ! ',
                              style: TextStyles.mediumRegularSubdued,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Add new Vendors ',
                              style: TextStyles.mediumRegularSubdued,
                            ),
                          ],
                        ),
                      )),
                state.isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: CustomProgressIndicator(),
                      )
                    : Container(),
              ],
            ),
          );
          // );
        }),
      ),
    );
  }
}
