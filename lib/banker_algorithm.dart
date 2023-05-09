import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:os_assignment/banker_func.dart';
import 'package:os_assignment/progess_animation.dart';
import 'package:os_assignment/progress_animation_start.dart';

class BankerAlgorithmPage extends StatefulWidget {
  @override
  _BankerAlgorithmPageState createState() => _BankerAlgorithmPageState();
}

class _BankerAlgorithmPageState extends State<BankerAlgorithmPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _allocationController = TextEditingController();
  final _maxController = TextEditingController();
  final _availableController = TextEditingController();
  final _resourceController = TextEditingController();
  final _processController = TextEditingController();

  final _inputRegex = RegExp(r"\d|\s");

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _animation = Tween<Offset>(
      begin: Offset(-0.9, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _allocationController.dispose();
    _maxController.dispose();
    _availableController.dispose();
    _resourceController.dispose();
    _processController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banker's Algorithm"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SlideTransition(
              position: _animation,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Text(
                  "Please enter the following inputs:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    SizedBox(height: 16.0),
                    buildInputField(
                      "Enter the Allocation",
                      _allocationController,
                      1000,
                      10,
                    ),
                    SizedBox(height: 16.0),
                    buildInputField(
                      "Enter the Maximum",
                      _maxController,
                      1000,
                      10,
                    ),
                    SizedBox(height: 16.0),
                    buildInputField(
                      "Available Vector",
                      _availableController,
                      100,
                      1,
                    ),
                    SizedBox(height: 16.0),
                    buildInputField(
                      "Resource Number",
                      _resourceController,
                      100,
                      1,
                    ),
                    SizedBox(height: 16.0),
                    buildInputField(
                      "Process Number",
                      _processController,
                      100,
                      1,
                    ),
                    SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProgressAnimationStart(
                              newCustomFunction(
                                _allocationController.text.trim(),
                                _maxController.text.trim(),
                                _availableController.text.trim(),
                                _processController.text.trim(),
                                _resourceController.text.trim(),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(
    String labelText,
    TextEditingController controller,
    int maxLength,
    int maxLines,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(_inputRegex),
      ],
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        counterText: "",
      ),
    );
  }
}
