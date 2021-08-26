import 'package:oogie/special_components/oogie_stepper.dart';
import 'package:flutter/cupertino.dart';
class StepperHorizontal extends StatelessWidget {
  int index;

  StepperHorizontal(this.index);

  @override
  Widget build(BuildContext context) {
    return OogieStepper(
      currentStep: index,
      controlsBuilder: (BuildContext context,
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
      type: OogieStepperType.horizontal,
      steps: <Step>[
        Step(
          title: const Text('Shipping'),
          state: index==0?StepState.editing:StepState.complete,
          content: Container(),
        ),
        Step(
          title: Text('Payment'),
          isActive: true,
          state: index==1?StepState.editing:index==0?StepState.indexed:StepState.complete,
          content: Container(),
        ),
        Step(
          title: Text('Review'),
          state:index==2?StepState.editing:StepState.indexed,

          content: Container(),
        ),
      ],
    );
  }
}
