import 'package:flutter/cupertino.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/special_components/oogie_stepper.dart';

class StepperVertical extends StatefulWidget {
  int index;
  bool isEditable;

  StepperVertical({this.index, this.isEditable = false});

  @override
  _StepperVerticalState createState() => _StepperVerticalState();
}

class _StepperVerticalState extends State<StepperVertical> {
  int index;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    index=widget.index;
  }
  @override
  Widget build(BuildContext context) {
    return OogieStepper(
      physics: NeverScrollableScrollPhysics(),
      currentStep: index,
      onStepCancel: () {
        if (index > 0) {
          setState(() { index -= 1; });
        }
      },
      onStepContinue: () {
        if (index <3) {
          setState(() { index += 1; });
        }
      },
      onStepTapped: (int index) {
        setState(() { index = index; });
      },
      controlsBuilder:  widget.isEditable?null:(BuildContext context,
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
      steps: <Step>[
        Step(
          title: const Text('Ordered'),
          subtitle: Text(
            'Lorem ipsum dolor sit ',
            style: TextStyles.tinyRegularSubdued,
          ),
          state: index == 0 ? StepState.editing : StepState.complete,
          content: Container(),
        ),
        Step(
          title: Text('Packed'),
          subtitle: Text(
            'Lorem ipsum dolor sit ',
            style: TextStyles.tinyRegularSubdued,
          ),
          isActive: true,
          state: widget == 1
              ? StepState.editing
              : widget == 0
                  ? StepState.indexed
                  : StepState.complete,
          content: Container(),
        ),
        Step(
          title: Text('Shipped'),
          subtitle: Text(
            'Lorem ipsum dolor sit ',
            style: TextStyles.tinyRegularSubdued,
          ),
          state: widget == 2
              ? StepState.editing
              : widget == 3
                  ? StepState.complete
                  : StepState.indexed,
          content: Container(),
        ),
        Step(
          title: Text('Delivery'),
          subtitle: Text(
            'Lorem ipsum dolor sit ',
            style: TextStyles.tinyRegularSubdued,
          ),
          state: widget.index == 3 ? StepState.editing : StepState.indexed,
          content: Container(),
        ),
      ],
    );
  }
}
