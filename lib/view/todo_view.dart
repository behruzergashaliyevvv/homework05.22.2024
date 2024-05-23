// lib/views/todo_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uyishi/todo_controller.dart';

class TodoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey, // AppBar background color
      ),
      body: Container(
        color: Colors.blueGrey[200], // Body background color
        child: Column(
          children: [
            Expanded(
              child: Consumer<TodoController>(
                builder: (context, controller, child) {
                  return ListView.builder(
                    itemCount: controller.todos.length,
                    itemBuilder: (context, index) {
                      final todo = controller.todos[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(todo.title),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: todo.isDone,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      controller.updateTodoStatus(
                                          todo.id, value);
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    controller.deleteTodo(todo.id);
                                  },
                                ),
                              ],
                            ),
                            onLongPress: () {
                              controller.deleteTodo(todo.id);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer<TodoController>(
                      builder: (context, controller, child) {
                        return Text(
                          'Completed: ${controller.completedCount}',
                          style: TextStyle(fontSize: 16),
                        );
                      },
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.black,
                    ),
                    Consumer<TodoController>(
                      builder: (context, controller, child) {
                        return Text(
                          'Incomplete: ${controller.incompleteCount}',
                          style: TextStyle(fontSize: 16),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddTodoDialog(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey, // FAB background color
      ),
    );
  }

  void _displayAddTodoDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add To-Do"),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Enter to-do title'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('ADD'),
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  Provider.of<TodoController>(context, listen: false).addTodo(
                    titleController.text,
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
