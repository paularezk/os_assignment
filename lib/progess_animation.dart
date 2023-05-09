import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;

  const AnimatedText(this.text, {Key? key}) : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween<Offset>(begin: Offset(0.0, -0.5), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Text(widget.text,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
    );
  }
}

class ProgressBarAnimation extends StatefulWidget {
  final List<int> processes;

  const ProgressBarAnimation({Key? key, required this.processes})
      : super(key: key);

  @override
  _ProgressBarAnimationState createState() => _ProgressBarAnimationState();
}

class _ProgressBarAnimationState extends State<ProgressBarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _progress = 0.0;
  int _completedProcesses = 0;
  int _totalProcesses = 0;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _totalProcesses = widget.processes.length;
    _animationController = AnimationController(
        duration: Duration(seconds: _totalProcesses * 2), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: _totalProcesses.toDouble())
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {
          _progress = _animation.value;
          _completedProcesses = _progress ~/ (1 / _totalProcesses);
        });
      });
    _animationController.forward();

    // // Start the timer to pop after 10 seconds
    // _timer = Timer(Duration(seconds: 10), () {
    //   Navigator.pop(context);
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer
        .cancel(); // Cancel the timer to prevent it from running after the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.processes[0] == 0 && widget.processes[1] == 0) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(child: AnimatedText("Deadlock Happened")),
      );
    }
    if (_completedProcesses >= _totalProcesses) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
            child:
                AnimatedText("The processes have been completed successfully")),
      );
    }
    var sizing = MediaQuery.of(context).size;
    var segmentWidth = sizing.width / _totalProcesses;
    var segmentStart = _completedProcesses * segmentWidth;
    // The time after which the navigator will pop
    const Duration popTime = Duration(seconds: 10);
    Future.delayed(popTime).then((_) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });

    var segmentEnd = segmentStart + segmentWidth;
    var segmentProgress =
        (_progress - _completedProcesses / _totalProcesses) * _totalProcesses;
    var segmentProgressStart = (segmentProgress - 0.2).clamp(0, 1);
    var segmentProgressEnd = (segmentProgress + 0.2).clamp(0, 1);
    return GestureDetector(
      onTap: () => _animationController.stop(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: List.generate(
              widget.processes.length,
              (index) {
                final process = widget.processes[index];
                final segmentWidth = MediaQuery.of(context).size.width /
                    widget.processes
                        .length; // Divide the width equally based on the number of processes
                final progress = _progress * widget.processes.length;
                final segmentProgress = (progress - index).clamp(
                    0, 1); // Calculate the progress for the current segment
                return Padding(
                  padding: EdgeInsets.only(left: segmentWidth * index),
                  child: SizedBox(
                    width: segmentWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedText("Process ${index + 1}: $process"),
                        SizedBox(height: 10.0),
                        Stack(
                          children: [
                            Container(
                              height: 20.0,
                              width: segmentWidth,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              height: 20.0,
                              width: segmentWidth * segmentProgress,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              alignment:
                                  Alignment(segmentProgress * 2 - 1, 0.0),
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          if (widget.processes[0] == 0 && widget.processes[1] == 0)
            AnimatedText("Deadlock Happened"),
        ],
      ),
    );
  }
}
