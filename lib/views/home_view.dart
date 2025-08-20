import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/views/add_task_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? username;
  List<TaskModel> task = [];
  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTask();
  }

  void _loadUserName() async {
    final pref = await SharedPreferences.getInstance();
    username = pref.getString('username');

    setState(() {});
  }

  void _loadTask() async {
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString('task');
    // log(finalTask.toString());
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        task = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();

        // task = taskAfterDecode;
      });
    }

    // task = taskAfterDecode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AddTaskView(),
              ),
            );
            _loadTask();
          },
          label: Text('Add New Task'),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xff15B86C),
          foregroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      backgroundColor: const Color(0xff181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/person.png'),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening , $username',
                        style: TextStyle(
                          color: Color(0xfffffcfc),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'One task at a time.One step closer.',
                        style: TextStyle(
                          color: Color(0xffc6c6c6),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Yuhuu ,Your work Is',
                textAlign: TextAlign.start,
                style: TextStyle(color: Color(0xfffffcfc), fontSize: 32),
              ),
              Row(
                children: [
                  Text(
                    'almost done !',

                    style: TextStyle(color: Color(0xfffffcfc), fontSize: 32),
                  ),
                  SvgPicture.asset('assets/images/hands.svg'),
                ],
              ),
              const SizedBox(height: 20),

              // if (task.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Text(
                  'My Tasks',
                  style: TextStyle(color: Color(0xfffffcfc), fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 60),
                  itemCount: task.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),

                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 56,
                        // alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff282828),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              // tristate: true,
                              value: task[index].isDone,
                              onChanged: (bool? value) async {
                                // log(value.toString());
                                setState(() {
                                  task[index].isDone = value ?? false;
                                });
                                final pref =
                                    await SharedPreferences.getInstance();
                                final updatedTak = task
                                    .map((element) => element.toJson())
                                    .toList();
                                pref.setString('task', jsonEncode(updatedTak));
                              },
                              activeColor: Color(0xff15B86C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),

                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task[index].taskName,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: task[index].isDone
                                          ? Color(0xffa0a0a0)
                                          : Color(0xfffffcfc),
                                      decoration: task[index].isDone
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      decorationColor: Color(0xffa0a0a0),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    task[index].taskDescription,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: task[index].isDone
                                          ? Color(0xffa0a0a0)
                                          : Color(0xfffffcfc),
                                      decoration: task[index].isDone
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      decorationColor: Color(0xffa0a0a0),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.more_vert_outlined,
                                color: task[index].isDone
                                    ? Color(0xffa0a0a0)
                                    : Color(0xffc6c6c6),
                              ),
                              onPressed: () async {
                                task.removeAt(index);
                                final pref =
                                    await SharedPreferences.getInstance();
                                final updatedTak = task
                                    .map((element) => element.toJson())
                                    .toList();
                                pref.setString('task', jsonEncode(updatedTak));
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
