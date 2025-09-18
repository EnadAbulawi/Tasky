import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class CompleteTasksView extends StatefulWidget {
  const CompleteTasksView({super.key});

  @override
  State<CompleteTasksView> createState() => _CompleteTasksViewState();
}

class _CompleteTasksViewState extends State<CompleteTasksView> {
  List<TaskModel> completeTasks = [];

  @override
  void initState() {
    _loadTask();
    super.initState();
  }

  void _loadTask() async {
    final finalTask = PreferencesManager().getString('task');

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        completeTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone == true)
            .toList();
      });
    }
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManager().getString('task');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((element) => element.id == id);
      setState(() {
        completeTasks.removeWhere((task) => task.id == id);
      });

      final updatedTask = tasks.map((e) => e.toJson()).toList();
      await PreferencesManager().setString('task', jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Complete Tasks',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TaskListWidget(
              tasks: completeTasks,
              emptyMsg: 'No Completed Task',
              onTap: (bool? value, int? index) async {
                setState(() {
                  completeTasks[index ?? 0].isDone = value ?? false;
                });

                final allData = PreferencesManager().getString('task');
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((element) => TaskModel.fromJson(element))
                      .toList();
                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == completeTasks[index!].id,
                  );
                  allDataList[newIndex] = completeTasks[index!];
                  await PreferencesManager().setString(
                    'task',
                    jsonEncode(allDataList),
                  );

                  _loadTask();
                }
              },
              onDelete: (int? id) => _deleteTask(id),
              onEdit: () => _loadTask(),
            ),
          ),
        ),
      ],
    );
  }
}
