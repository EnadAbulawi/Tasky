import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      appBar: AppBar(
        title: const Text('New Task', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff181818),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xff181818),
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
                      Text(
                        'Task Name',
                        style: TextStyle(
                          color: Color(0xffFFFCFC),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onTapOutside: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Task Name";
                          }
                          return null;
                        },
                        controller: taskNameController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,

                          fillColor: const Color(0xff282828),
                          hintText: 'Finish UI design for login screen',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Task Description',
                        style: TextStyle(
                          color: Color(0xffFFFCFC),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onTapOutside: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        // validator: (String? value) {
                        //   if (value == null || value.trim().isEmpty) {
                        //     return "Please Enter Task Description";
                        //   }
                        //   return null;
                        // },
                        controller: taskDescriptionController,
                        maxLines: 7,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff282828),
                          hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'High Priority',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),

                          Switch(
                            value: isHighPriority,
                            onChanged: (value) {
                              isHighPriority = value;
                              setState(() {});
                              log(isHighPriority.toString());
                            },
                            activeTrackColor: Color(0xff15b86c),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff15b86c),
                  foregroundColor: Color(0xfffffcfc),
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    TaskModel model = TaskModel(
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    log(model.toJson().toString());

                    final pref = await SharedPreferences.getInstance();
                    final taskJson = pref.getString('task');
                    List<dynamic> listTasks = [];
                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }
                    listTasks.add(model.toJson());
                    final taskEncode = jsonEncode(listTasks);
                    await pref.setString('task', taskEncode);

                    Navigator.pop(context);
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
