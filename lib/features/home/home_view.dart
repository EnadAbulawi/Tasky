import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/add_task/add_task_view.dart';
import 'package:tasky/features/home/components/achived_task_widget.dart';
import 'package:tasky/features/home/components/high_priority_task_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky/features/home/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController(),

      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          final HomeController controller = context.read<HomeController>();

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: value.profileImagePath != null
                                  ? FileImage(File(value.profileImagePath!))
                                  : AssetImage('assets/images/person.png'),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good Evening , ${value.username}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  'One task at a time.One step closer.',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Yuhuu ,Your work Is',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              'almost done !',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            CustomSvgPicture.withoutColor(
                              path: 'assets/images/hands.svg',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AchievedTasksWidget(
                          doneTasks: value.doneTasks,
                          totalTasks: value.totalTasks,
                          percent: value.percent,
                        ),
                        const SizedBox(height: 8),
                        HighPriorityTaskWidget(
                          tasks: value.task,
                          onTap: (bool? value, int? index) {
                            controller.doneTasks(value, index);
                          },
                          refresh: () {
                            controller.loadTask();
                          },
                        ),
                        // if (task.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 16),
                          child: Text(
                            'My Tasks',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SliverTaskListWidget(
                    tasks: value.task,
                    onTap: (bool? value, int? index) {
                      controller.doneTasks(value, index);
                    },
                    onDelete: (int? id) => controller.deleteTask(id),
                    onEdit: () => controller.loadTask(),
                  ),
                ],
              ),
            ),
            floatingActionButton: SizedBox(
              height: 50,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddTaskView(),
                    ),
                  );

                  if (result != null && result == true) {
                    controller.loadTask();
                  }
                },
                label: Text('Add New Task'),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
