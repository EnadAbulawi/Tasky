import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_list_widget.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  List<TaskModel> todoTasks = [];
  bool isLoading = false;
  @override
  void initState() {
    _loadTask();
    super.initState();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });

    final finalTask = PreferencesManager().getString('task');
    // log(finalTask.toString());
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        todoTasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isDone == false)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
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
        todoTasks.removeWhere((task) => task.id == id);
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
          child: Text('Tasks', style: Theme.of(context).textTheme.labelSmall),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : TaskListWidget(
                    tasks: todoTasks,
                    onTap: (bool? value, int? index) async {
                      // log(value.toString());
                      setState(() {
                        todoTasks[index ?? 0].isDone = value ?? false;
                      });

                      final allData = PreferencesManager().getString('task');
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();
                        final newIndex = allDataList.indexWhere(
                          (e) => e.id == todoTasks[index!].id,
                        );
                        allDataList[newIndex] = todoTasks[index!];
                        await PreferencesManager().setString(
                          'task',
                          jsonEncode(allDataList),
                        );

                        _loadTask();
                      }
                    },
                    emptyMsg: 'No Task',
                    onDelete: (int? id) => _deleteTask(id),
                    onEdit: () => _loadTask(),
                  ),
          ),
        ),
      ],
    );
  }
}
