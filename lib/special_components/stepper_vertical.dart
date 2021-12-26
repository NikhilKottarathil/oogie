import 'package:flutter/cupertino.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/special_components/oogie_stepper.dart';

class StepperVertical extends StatefulWidget {
  bool isEditable;
  String deliveryState;
  List<DeliveryState> deliveryStatuses;
  String parentPage;
  Function reviewAction;
  String reviewId;
  List<String> statuses = [
    'Placed',
    'Shipped',
    'Fulfilled',
    'Return Initiated',
    'Return Completed',
    'Cancelled'
  ];

  StepperVertical(
      {this.isEditable = false,
      this.deliveryStatuses,
      this.deliveryState,
      this.parentPage,

        this.reviewId,
      this.reviewAction});

  @override
  _StepperVerticalState createState() => _StepperVerticalState();
}

class _StepperVerticalState extends State<StepperVertical> {
  int currentIndex;

  int stepperLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stepperLength = widget.deliveryState == 'Cancelled'
        ? widget.deliveryStatuses.length
        : widget.deliveryStatuses.length >= 4
            ? 5
            : 3;
    currentIndex = widget.deliveryStatuses.length - 1;
    print('widget.deliveryStatuses.length');
    print(widget.deliveryStatuses.length);
  }

  @override
  Widget build(BuildContext context) {
    return OogieStepper(
      physics: NeverScrollableScrollPhysics(),
      currentStep: currentIndex,
      onStepCancel: () {
        if (currentIndex > 0) {
          setState(() {
            currentIndex -= 1;
          });
        }
      },
      onStepContinue: () {
        if (currentIndex < 3) {
          setState(() {
            currentIndex += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          index = index;
        });
      },
      controlsBuilder: widget.isEditable
          ? null
          : (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                children: <Widget>[
                  Container(
                    child: null,
                  ),
                  Container(
                    child: null,
                  ),
                ],
              );
            },
      type: OogieStepperType.vertical,
      steps: List.generate(
          stepperLength,
          (index) => Step(
                title: Text(
                  index <= widget.deliveryStatuses.length - 1
                      ? widget.deliveryStatuses[index].name
                      : widget.statuses[index],
                  style: TextStyles.smallRegular,
                ),
                subtitle: Text(
                  index <= widget.deliveryStatuses.length - 1
                      ? widget.deliveryStatuses[index].datetimeString
                      : '',
                  style: TextStyles.tinyRegularSubdued,
                ),
                // state: index>widget.deliveryStatuses.length-1?StepState.indexed:index ==widget.deliveryStatuses.length-1 ? StepState.editing : StepState.complete,
                state: index > widget.deliveryStatuses.length - 1
                    ? StepState.indexed
                    : StepState.complete,
                content: index == 4 && widget.parentPage == 'myOrders'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'The amount will refunded to your account with in 24 hours after pickup completed',
                            style: TextStyles.smallRegularSubdued,
                          ),
                          Text(
                            'If the amount not credited to account please   ',
                            style: TextStyles.smallRegularSubdued,
                          ),
                          CustomTextButton2(
                            text: 'ContactCustomer Care',
                            action: () {
                              // Navigator.pushReplacementNamed(
                              //     context, '/signUp');
                            },
                          )
                        ],
                      )
                    : index == 2 &&
                            widget.parentPage == 'myOrders' &&
                            (widget.deliveryState == 'Fulfilled' ||
                                widget.deliveryState == 'Return Initiated' ||
                                widget.deliveryState == 'Return Completed')&& widget.reviewId==null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Please rate and review product',
                                style: TextStyles.smallRegularSubdued,
                              ),
                              CustomTextButton2(
                                text: 'Review Product',
                                action: () {
                                  widget.reviewAction();
                                },
                              )
                            ],
                          )
                        : Container(),
              )),
    );
  }
}
