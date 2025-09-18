import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tasky/core/enums/task_item_action_enum.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.tasks,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel tasks;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xffd1dad6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomCheckBox(
            value: tasks.isDone,
            onChanged: (value) {
              onChanged(value);
            },
          ),

          const SizedBox(width: 16),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tasks.taskName,
                  style: tasks.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                if (tasks.taskDescription.isNotEmpty)
                  Text(
                    tasks.taskDescription,
                    style: tasks.isDone
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.titleMedium,

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          // const Spacer(),
          PopupMenuButton<TaskItemActionsEnum>(
            icon: Icon(
              Icons.more_vert_outlined,
              color: ThemeController.isDark()
                  ? (tasks.isDone ? Color(0xffa0a0a0) : Color(0xffc6c6c6))
                  : tasks.isDone
                  ? Color(0xff6a6a6a)
                  : Color(0xff3a4640),
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markAsDone:
                  onChanged(!tasks.isDone);
                  break;
                case TaskItemActionsEnum.edit:
                  final result = await _showBottomSheet(context, tasks);
                  if (result != null) {
                    onEdit();
                  }
                  break;
                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
                  onDelete(tasks.id);
                  break;
              }
            },
            itemBuilder: (context) => TaskItemActionsEnum.values
                .map(
                  (e) => PopupMenuItem<TaskItemActionsEnum>(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Future _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                onDelete(tasks.id);
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showBottomSheet(BuildContext context, TaskModel model) async {
    final taskNameController = TextEditingController(text: model.taskName);
    final taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    final key = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;

    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      // isDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, void Function(void Function()) setState) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Center(
                                child: Container(
                                  height: 4,
                                  width: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              CustomTextFormField(
                                title: 'Task Name',
                                controller: taskNameController,
                                hintText: 'Finish UI design for login screen',
                                validator: (String? value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please Enter Task Name";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),
                              CustomTextFormField(
                                title: 'Task Description',
                                controller: taskDescriptionController,
                                hintText:
                                    'Finish onboarding UI and hand off to devs by Thursday.',
                                maxLines: 7,
                              ),

                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'High Priority',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),

                                  Switch(
                                    value: isHighPriority,
                                    onChanged: (value) {
                                      isHighPriority = value;
                                      setState(() {});
                                      log(isHighPriority.toString());
                                    },
                                    // activeTrackColor: Color(0xff15b86c),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            50,
                          ),
                        ),
                        onPressed: () async {
                          if (key.currentState?.validate() ?? false) {
                            //   //check by key {tasks} > String ?
                            final taskJson = PreferencesManager().getString(
                              'task',
                            );
                            List<dynamic> listTasks = [];
                            if (taskJson != null) {
                              listTasks = jsonDecode(taskJson);
                            }

                            TaskModel newModel = TaskModel(
                              // id: listTasks.length =1 -> 1 + 1,
                              id: model.id,
                              taskName: taskNameController.text,
                              taskDescription: taskDescriptionController.text,
                              isHighPriority: isHighPriority,
                              isDone: model.isDone,
                            );
                            final item = listTasks.firstWhere(
                              (e) => e['id'] == model.id,
                            );
                            final int index = listTasks.indexOf(item);
                            listTasks[index] = newModel;

                            final taskEncode = jsonEncode(listTasks);
                            await PreferencesManager().setString(
                              'task',
                              taskEncode,
                            );

                            Navigator.of(context).pop(true);
                            //   // setState(() {});
                          }
                        },
                        label: Text('Edit Task'),
                        icon: const Icon(Icons.edit),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
