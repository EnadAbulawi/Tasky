import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/features/tasks/high_priority_view.dart';

class HighPriorityTaskWidget extends StatelessWidget {
  const HighPriorityTaskWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'High Priority Tasks',
                    style: TextStyle(
                      color: Color(0xff18b86c),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // padding: EdgeInsets.only(left: 16, bottom: 16),
                  itemCount:
                      tasks.reversed.where((e) => e.isHighPriority).length > 4
                      ? 4
                      : tasks.where((e) => e.isHighPriority).length,
                  itemBuilder: (context, index) {
                    final task = tasks.reversed
                        .where((e) => e.isHighPriority)
                        .toList()[index];
                    return Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomCheckBox(
                          value: task.isDone,
                          onChanged: (value) {
                            final index = tasks.indexWhere(
                              (e) => e.id == task.id,
                            );
                            onTap(value, index);
                          },
                        ),

                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            task.taskName,
                            style: task.isDone
                                ? Theme.of(context).textTheme.titleLarge
                                : Theme.of(context).textTheme.titleMedium,

                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HighPriorityTasksView(),
                ),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                // width: 48,
                // height: 56,
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: CustomSvgPicture(
                  path: 'assets/images/arrow_up_right.svg',
                  width: 18,
                  height: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
