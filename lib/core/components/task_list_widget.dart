import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
    this.emptyMsg,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int? index) onTap;
  final Function(int?) onDelete;
  final Function onEdit;
  String? emptyMsg;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMsg ?? 'No Task',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(bottom: 60),
            itemCount: tasks.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(
                tasks: tasks[index],
                onChanged: (bool? value) {
                  onTap(value, index);
                },
                onDelete: (int id) => onDelete(id),
                onEdit: () => onEdit(),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 8);
            },
          );
  }
}
