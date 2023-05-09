import 'package:flutter/material.dart';
import 'package:os_assignment/progess_animation.dart';

import 'banker_algorithm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(body: BankerAlgorithmPage()));
  }
}
