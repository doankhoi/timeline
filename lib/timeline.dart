library timeline;

import 'package:flutter/material.dart';
import 'package:osbkca_timeline/step.dart';
import 'package:osbkca_timeline/steps.dart';

class TimelineScreen extends StatefulWidget {
  final MaterialPageRoute pageRoute;
  final List<StepTimeline> steps;
  final Function builder;
  final int currentStepIndex;

  const TimelineScreen(
      {Key key,
      this.pageRoute,
      this.steps,
      this.builder,
      this.currentStepIndex})
      : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Timeline(
      currentStepIndex: widget.currentStepIndex,
      builder: widget.builder,
      steps: widget.steps,
    );
  }
}
