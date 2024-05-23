// lib/controllers/todo_controller.dart
import 'package:flutter/material.dart';

import 'package:uyishi/todo.dart';

class TodoController with ChangeNotifier {
  List<Todo> _todos = [];
  int _nextId = 0;

  List<Todo> get todos => _todos;

  void addTodo(String title) {
    _todos.add(Todo(
      id: _nextId++,
      title: title,
    ));
    notifyListeners();
  }

  void updateTodoStatus(int id, bool isDone) {
    for (var todo in _todos) {
      if (todo.id == id) {
        todo.isDone = isDone;
        break;
      }
    }
    notifyListeners();
  }

  void deleteTodo(int id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  int get completedCount => _todos.where((todo) => todo.isDone).length;

  int get incompleteCount => _todos.where((todo) => !todo.isDone).length;
}
