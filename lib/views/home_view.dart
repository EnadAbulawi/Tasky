import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/views/add_task_view.dart';
import 'package:tasky/widgets/achived_task_widget.dart';
import 'package:tasky/widgets/high_priority_task_widget.dart';
import 'package:tasky/widgets/sliver_task_list_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? username;
  String? profileImagePath;
  List<TaskModel> task = [];
  bool isCheck = false;

  int totalTasks = 0;
  int doneTasks = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTask();
  }

  void _loadUserName() async {
    setState(() {
      username = PreferencesManager().getString('username');
      profileImagePath = PreferencesManager().getString('profile_image');
    });
  }

  void _loadTask() async {
    final finalTask = PreferencesManager().getString('task');
    // log(finalTask.toString());
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        task = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
        _calculatePercent();
      });
    }
  }

  _calculatePercent() {
    totalTasks = task.length;
    doneTasks = task.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : doneTasks / totalTasks;
  }

  _doneTasks(bool? value, int? index) async {
    setState(() {
      task[index!].isDone = value ?? false;
      _calculatePercent();
    });

    final updatedTak = task.map((element) => element.toJson()).toList();
    await PreferencesManager().setString('task', jsonEncode(updatedTak));
  }

  _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      task.removeWhere((task) => task.id == id);
    });

    _calculatePercent();
    final updatedTask = task.map((e) => e.toJson()).toList();
    await PreferencesManager().setString('task', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
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
                        backgroundImage: profileImagePath != null
                            ? FileImage(File(profileImagePath!))
                            : AssetImage('assets/images/person.png'),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Evening , $username',
                            style: Theme.of(context).textTheme.titleMedium,
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
                    doneTasks: doneTasks,
                    totalTasks: totalTasks,
                    percent: percent,
                  ),
                  const SizedBox(height: 8),
                  HighPriorityTaskWidget(
                    tasks: task,
                    onTap: (bool? value, int? index) {
                      _doneTasks(value, index);
                    },
                    refresh: () {
                      _loadTask();
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
              tasks: task,
              onTap: (bool? value, int? index) {
                _doneTasks(value, index);
              },
              onDelete: (int? id) => _deleteTask(id),
              onEdit: () => _loadTask(),
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
              _loadTask();
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
  }
}
