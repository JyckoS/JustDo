import 'package:flutter/material.dart';
import 'package:justdo/constants/app_colors.dart';
import 'package:justdo/controllers/auth_controller.dart';
import 'package:justdo/controllers/todo_controller.dart';
import 'package:justdo/models/todo.dart';

class TodoRow extends StatelessWidget {
  const TodoRow({
    super.key,
    required this.todo,
    required this.controller,
    required this.index,
  });
  final int index;
  final Todo todo;
  final TodoController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Checkbox(
            value: todo.completed,
            activeColor: AppColors.secondaryColor,
            checkColor: AppColors.backgroundColor,
            onChanged: (_) => controller.toggleCompleted(index, todo),
          ),
          Expanded(
            child: Text(
              todo.title,
              style: TextStyle(
                color: todo.completed ? AppColors.textSecondary : AppColors.textColor,
                decoration: todo.completed ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: AppColors.errorColor,
            onPressed: () => controller.deleteTodo(index),
          )
        ],
      ),
    );
  }
}
