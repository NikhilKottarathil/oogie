import 'package:flutter/material.dart';
import 'package:oogie/components/default_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

datePickerFromAndTo(
    {BuildContext context, DateTime fromDate, DateTime toDate}) async {
  DateRangePickerController _controller = DateRangePickerController();
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args.value);

    if (args.value is PickerDateRange) {
      fromDate = args.value.startDate;

      fromDate = DateTime(fromDate.year, fromDate.month, fromDate.day, 0, 0);

      toDate = args.value.endDate ?? args.value.startDate;
      toDate = DateTime(toDate.year, toDate.month, toDate.day, 23, 59);
    }
  }

  await showModalBottomSheet(
      context: context,
      enableDrag: true,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;

        return Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 35),
          height: height * .6,
          margin: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Expanded(
                child: SfDateRangePicker(
                  controller: _controller,
                  enablePastDates: true,
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  headerStyle: DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(color: Colors.black, fontSize: 18)),
                  initialSelectedRange: PickerDateRange(fromDate, toDate),
                  // initialSelectedRange: PickerDateRange(DateTime.now().subtract(const Duration(days: 7)),DateTime.now()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Container(
                  //   width: MediaQuery.of(context).size.width * .4,
                  //   child: BorderButtonWithoutShade(
                  //     text: 'Cancel',
                  //     action: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //   ),
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    child: DefaultButton(
                      text: 'Submit',
                      action: () {
                        Navigator.pop(builder);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
  // return [_controller.selectedDates[0], _controller.selectedDates[_controller.selectedDates.length-1],];
  return [fromDate, toDate];
}
