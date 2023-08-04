import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/bodyScreens/Home/bloc/task_list_bloc.dart';
import 'package:todo/app/bodyScreens/edit/cubit/edit_cubit_cubit.dart';
import 'package:todo/app/bodyScreens/Home/myCheckBox.dart';
import 'package:todo/app/bodyScreens/edit/editTaskScree.dart';
import 'package:todo/app/models/task.dart';
import 'package:todo/data/repo/repository.dart';
import 'package:todo/main.dart';

class TaskItem extends StatefulWidget {
  final TaskEntity task;
  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    double height = 74;
    ThemeData themeData = Theme.of(context);
    final Color thisPriorityColor;

    switch (widget.task.priority) {
      case Priority.normal:
        thisPriorityColor = normalPeriority;
        break;
      case Priority.high:
        thisPriorityColor = primaryColor;
        break;
      case Priority.low:
        thisPriorityColor = lowPeriority;
        break;
    }
    return InkWell(
      // --------------without Bloc-------------------------
      // onTap: () {
      //   setState(() {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => EditTaskScreen(task: widget.task)));
      //   });
      // },

      //---------------------------With Bloc----------------------

      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider<EditTaskCubit>(
                        create: (context) => EditTaskCubit(widget.task,
                            context.read<Repository<TaskEntity>>()),
                        child: const EditTaskScreen(),
                      )));
        });
      },

      // onLongPress: () {
      //   setState(() {
      //        final repositroy =
      //         Provider.of<Repository<TaskEntity>>(context, listen: false);
      //     repositroy.delete(widget.task);

      //   });
      // },
      // --------------without Bloc----------------------------
      onLongPress: () {
        setState(() {
          context.read<TaskListBloc>().add(DeleteTaskItem(widget.task));
        });
      },
      //---------------------------With Bloc----------------------
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: height,
        decoration: BoxDecoration(
            color: themeData.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))
            ]),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  widget.task.isCompleted = !widget.task.isCompleted;
                });
              },
              child: MyCheckBox(
                value: widget.task.isCompleted,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(widget.task.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: widget.task.isCompleted
                      ? const TextStyle(fontSize: 12, color: secodaryTextColor)
                      : const TextStyle(fontSize: 16, color: Colors.black)),
            ),
            Container(
              width: 8,
              height: 80,
              decoration: BoxDecoration(
                  color: widget.task.isCompleted
                      ? Colors.green.shade800
                      : thisPriorityColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      topRight: Radius.circular(16))),
            ),
          ],
        ),
      ),
    );
  }
}
