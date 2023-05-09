import 'package:flutter/material.dart';
import 'package:os_assignment/progess_animation.dart';

class ProgressAnimationStart extends StatelessWidget {
  final List<int> processes1;

  const ProgressAnimationStart(this.processes1, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressBarAnimation(processes: processes1),
    );
  }
}
