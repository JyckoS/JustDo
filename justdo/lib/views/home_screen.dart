
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justdo/constants/app_colors.dart';
import 'package:justdo/controllers/auth_controller.dart';
import 'package:justdo/controllers/todo_controller.dart';
import 'package:justdo/models/todo.dart';
import 'package:justdo/widgets/home_screen/todo_row.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TodoController controller = Get.put(TodoController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // make a bottom sheet to a clickable link to the github repo
      bottomSheet: Container(
        color: AppColors.backgroundColor,
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Made with ❤️ by JicoSoft',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            GestureDetector(
              onTap: () async {
                // open github repo in another tab
                print("Go github");
                    final Uri url = Uri.parse('https://github.com/JyckoS/JustDo/tree/main/justdo');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
              },
              child: Text(
                ' OPEN SOURCE CODE',
                style: TextStyle(color: AppColors.primaryColor, decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          color: Colors.white,
          onPressed: () => authController.logout(),
        ),
        title: const Text('My TODOs'),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: Obx(() {
        final todos = controller.todos;
        
if (todos.isEmpty) {
          return Center(
            child: Text(
              'No tasks yet',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: todos.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoRow(todo: todo, controller: controller, index: index,);
          },
        );
  
    
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.secondaryColor,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () => controller.addTodoDialog(),
        
      ),
    );
  }
}
