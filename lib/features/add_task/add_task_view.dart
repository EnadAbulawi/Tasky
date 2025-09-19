import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  /// TODO : DISPOSE THIS CONTROLLERS

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Task')),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('High Priority', style: TextStyle(fontSize: 18)),

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
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    //check by key {tasks} > String ?
                    final taskJson = PreferencesManager().getString('task');
                    List<dynamic> listTasks = [];
                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }

                    TaskModel model = TaskModel(
                      // id: listTasks.length =1 -> 1 + 1,
                      id: listTasks.length + 1,
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    log(model.toJson().toString());

                    listTasks.add(model.toJson());
                    final taskEncode = jsonEncode(listTasks);
                    await PreferencesManager().setString('task', taskEncode);

                    Navigator.of(context).pop(true);
                    // setState(() {});
                  }
                },
                label: Text('Add Task'),
                icon: const Icon(Icons.add),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
