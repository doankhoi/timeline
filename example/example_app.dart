import 'package:flutter/material.dart';
import 'package:osbkca_timeline/constants.dart';
import 'package:osbkca_timeline/step.dart';
import 'package:osbkca_timeline/timeline.dart';

class TestScreen extends StatelessWidget {
  final List<StepTimeline> steps = [
    StepChild(
      child: Text("Chuyen bay 1"),
    ),
    StepChild(
      child: Text("Chuyen bay 2"),
    ),
    StepChild(
      child: Text("Chuyen bay 3"),
    ),
    StepText(
      text: "Chuyen bay 4",
    )
  ];

  final Function builder = ({stepStatus, stepIndex}) {
    if (stepIndex == 0) {
      return Icon(
        Icons.airplanemode_active,
        size: 32,
      );
    }
    return Container(
        width: 36,
        height: 36,
        child: Center(child: Text((stepIndex + 1).toString())),
        color: stepStatus == StepStatus.Done ? Colors.green : Colors.grey);
  };

  final int currentStepIndex = 2;

  @override
  Widget build(BuildContext context) {
    return TimelineScreen(
      pageRoute: MaterialPageRoute(builder: (context) => new TestScreen()),
      steps: steps,
      currentStepIndex: currentStepIndex,
      builder: builder,
    );
  }
}
