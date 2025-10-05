import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? profileImagePath;
  List<TaskModel> task = [];
  bool isCheck = false;

  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;
  // * انشاء كونستركتور للكلاس لانه اول شيء ينادي به الكلاس عند استدعائه هو الكونستركتور
  HomeController() {
    init();
  }

  init() {
    loadUserName();
    loadTask();
  }

  void loadUserName() async {
    username = PreferencesManager().getString(StorageKey.username);
    profileImagePath = PreferencesManager().getString('profile_image');
    notifyListeners();
  }

  void loadTask() async {
    final finalTask = PreferencesManager().getString('task');
    // log(finalTask.toString());
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      task = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      calculatePercent();
      notifyListeners();
    }
  }

  calculatePercent() {
    totalTasks = task.length;
    totalDoneTasks = task.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }

  doneTasks(bool? value, int? index) async {
    task[index!].isDone = value ?? false;
    calculatePercent();

    final updatedTak = task.map((element) => element.toJson()).toList();
    await PreferencesManager().setString('task', jsonEncode(updatedTak));
    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;

    task.removeWhere((task) => task.id == id);

    calculatePercent();
    final updatedTask = task.map((e) => e.toJson()).toList();
    await PreferencesManager().setString('task', jsonEncode(updatedTask));
    notifyListeners();
  }
}
