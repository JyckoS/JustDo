import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:justdo/controllers/auth_controller.dart';
import 'package:justdo/models/todo.dart';
import 'package:justdo/services/todo_service.dart';

class TodoController extends GetxController {
  // the list of todos managed by GetX
  var todos = <Todo>[].obs;
  final TodoService todoService = TodoService();
  // load all data from server
  Future<void> loadTodo() async {
    List<Todo> todos = await todoService.fetchTodos();
    this.todos.value = todos;
  }


  /// Add a new todo locally and in the backend 
  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;
    // TODO: call REST API to create task
    Todo todo = Todo(title: title);
    todo = await todoService.addTodo(todo); // REPLACE LATER
    todos.add(todo);
  }

  /// Toggle the completed flag on the todo at [index].
  Future<void> toggleCompleted(int index, Todo todo) async {
    final item = todos[index];
    todos[index] = item; // trigger update

    Todo newTodo = await todoService.toggleCompleted(todo.id!);

    todos[index] = newTodo;

  }

  /// Remove the todo at [index].
  Future<void> deleteTodo(int index) async {
    // TODO: delete on backend
    Todo todo = todos[index];
    await todoService.deleteTodo(todo.id!); // REPLACE LATER
    todos.removeAt(index);
  }

  /// Display a dialog for entering a new todo item.
  void addTodoDialog() {
    String input = '';
    Get.defaultDialog(
      title: 'New Task',
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.black),
      content: Column(
        children: [
          TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter task'),
            onChanged: (v) => input = v,
            onSubmitted: (_) => _handleAdd(input),
          ),
        ],
      ),
      textCancel: 'Cancel',
      textConfirm: 'Add',
      confirmTextColor: Colors.white,
      onConfirm: () {
        _handleAdd(input);
        Get.back();
      },
    );
  }

  void _handleAdd(String value) {
    if (value.trim().isNotEmpty) {
      addTodo(value.trim());
    }
  }
}
