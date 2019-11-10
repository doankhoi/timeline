import 'package:flutter/material.dart';
import 'package:osbkca_timeline/step.dart';

import 'constants.dart';

typedef StepBuilder = Widget Function({StepStatus stepStatus, int stepIndex});

class Circle extends StatelessWidget {
  final Color color;

  const Circle({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final StepTimeline step;
  final int stepIndex;
  final StepStatus stepStatus;
  final bool isEven;
  final StepBuilder builder;

  StepItem(
      {Key key,
      this.step,
      this.builder,
      this.isEven,
      this.stepIndex,
      this.stepStatus})
      : super(key: key);

  Color _getColor(BuildContext context) {
    if (stepStatus == StepStatus.Processing) {
      return Theme.of(context).primaryColor;
    }
    if (stepStatus == StepStatus.Pending) {
      return Colors.grey;
    }
    return Theme.of(context).accentColor;
  }

  Widget _buildStepHead(context) {
    if (builder is Function) {
      return builder(stepStatus: stepStatus, stepIndex: stepIndex);
    }

    return Circle(color: _getColor(context));
  }

  @override
  Widget build(BuildContext context) {
    final rowContents = <Widget>[
      SizedBox(width: 12.0 + 16.0),
      Expanded(
        child: SizedBox(),
      ),
      Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            _buildStepHead(context),
            Expanded(
              child: Container(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 16.0,
        height: 1,
        color: Colors.grey,
      ),
      Expanded(
        child: step is StepText
            ? (step as StepChild).child
            : Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.amberAccent,
                ),
                padding: EdgeInsets.all(18.0),
                child: Container(
                  child: Text((step as StepText).text),
                ),
              ),
      ),
      SizedBox(width: 12.0)
    ];

    return Container(
      constraints: BoxConstraints.expand(width: double.infinity, height: 120),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: isEven ? rowContents : rowContents.reversed.toList(),
      ),
    );
  }
}

class Timeline extends StatelessWidget {
  final int currentStepIndex;
  final List<StepTimeline> steps;
  final StepBuilder builder;

  Timeline({Key key, this.builder, this.currentStepIndex = 0, this.steps})
      : super(key: key);

  StepStatus _getStepStatus(int index) {
    if (index == currentStepIndex) {
      return StepStatus.Processing;
    } else if (index < currentStepIndex) {
      return StepStatus.Done;
    } else {
      return StepStatus.Pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: steps
              .asMap()
              .map((index, step) => MapEntry(
                  index,
                  StepItem(
                      step: step,
                      stepIndex: index,
                      stepStatus: _getStepStatus(index),
                      isEven: index % 2 == 0,
                      builder: builder)))
              .values
              .toList()),
    );
  }
}
