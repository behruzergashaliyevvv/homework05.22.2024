// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uyishi/todo_controller.dart';
import 'package:uyishi/view/todo_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter To-Do List",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoView(),
      ),
    );
  }
}
