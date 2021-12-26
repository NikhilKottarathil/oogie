import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/order_report_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/page_scroll_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/date_conversion.dart';
import 'package:oogie/functions/date_picker_from_and_to.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/screens/common/vendor_sale_report/generate_pdf.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_bloc.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_event.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_state.dart';

class VendorSaleReportView extends StatefulWidget {
  @override
  _VendorSaleReportViewState createState() => _VendorSaleReportViewState();
}

class _VendorSaleReportViewState extends State<VendorSaleReportView> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<VendorSaleReportBloc>().add(FetchMoreData());
      }
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: context.read<VendorSaleReportBloc>().parentPage == 'vendorHome'
          ? null
          : defaultAppBarWhite(
              context: context,
              text: 'Sale Report',
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.picture_as_pdf),
        backgroundColor: AppColors.PrimaryBase,
        onPressed: () {

          print('button Pressed');
          if(context.read<VendorSaleReportBloc>().state.displayModels.isNotEmpty) {
            PDF pdf = PDF();
            pdf.generateSalesReport(
                orderModels:
                context
                    .read<VendorSaleReportBloc>()
                    .state
                    .displayModels,
                fromDate: context
                    .read<VendorSaleReportBloc>()
                    .state
                    .fromDate,
                toDate: context
                    .read<VendorSaleReportBloc>()
                    .state
                    .toDate,
                userModel: context
                    .read<VendorSaleReportBloc>()
                    .userModel);
          }else{
            showSnackBar(context, Exception('You have no orders'));
          }
        },
      ),
      body: BlocListener<VendorSaleReportBloc, VendorSaleReportState>(
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
        child: BlocBuilder<VendorSaleReportBloc, VendorSaleReportState>(
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
                // Text(context.read<VendorSaleReportBloc>().userModel.name,style: TextStyles.mediumMedium,),
                // SizedBox(height: 12,),
                // Text(context.read<VendorSaleReportBloc>().userModel.phoneNumber,style: TextStyles.smallRegular,),
                // SizedBox(height: 12,),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.BorderDefault),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                              'From\t' +
                                  getDateString(state
                                      .fromDate.millisecondsSinceEpoch
                                      .toString()) +
                                  '\t to\t' +
                                  getDateString(state
                                      .toDate.millisecondsSinceEpoch
                                      .toString()),
                              style: TextStyles.smallRegular)),
                      IconButton(
                          icon: Icon(Icons.calendar_today_outlined),
                          onPressed: () async {
                            try {
                              var data = await datePickerFromAndTo(
                                  context: context,
                                  fromDate: state.fromDate,
                                  toDate: state.toDate);
                              context.read<VendorSaleReportBloc>().add(
                                  DateSelected(
                                      fromDate: data[0], toDate: data[1]));
                            } catch (e) {}
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.White,
                    boxShadow: AppShadows.shadowSmall,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: TextStyles.mediumMedium,
                        ),
                        Text(
                          'OrderID',
                          style: TextStyles.mediumMedium,
                        ),
                        Text(
                          'Total',
                          style: TextStyles.mediumMedium,
                        ),
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),

                state.displayModels.length != 0
                    ? Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.displayModels.length,
                          // itemCount: 100,
                          itemBuilder: (BuildContext context, int index) {
                            return OrderReportAdapter(
                                model: state.displayModels[index]);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                        child: Text(
                          'No Orders Yet !',
                          style: TextStyles.mediumRegularSubdued,
                        ),
                      )),
                state.isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(166.0),
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
