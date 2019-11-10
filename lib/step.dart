import 'package:flutter/material.dart';

class StepTimeline {}

class StepText extends StepTimeline {
  final String text;

  StepText({@required this.text});
}

class StepChild extends StepTimeline {
  final Widget child;

  StepChild({@required this.child});
}
