import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/bodyScreens/Home/selectPriorityScreen.dart';
import 'package:todo/app/bodyScreens/edit/cubit/edit_cubit_cubit.dart';
import 'package:todo/app/models/task.dart';
import 'package:todo/main.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late final TextEditingController _textEditingController;
  @override
  void initState() {
    _textEditingController = TextEditingController(
        text: context.read<EditTaskCubit>().state.task.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.surface,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<EditTaskCubit>().onSaveChangeKelick();
          Navigator.of(context).pop();
        },
        label: const Text('Save Change'),
        icon: const Icon(CupertinoIcons.check_mark_circled_solid),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Edit Task',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: themeData.colorScheme.surface,
        foregroundColor: themeData.colorScheme.onSurface,
      ),
      body: priorityStateController(),
    );
  }

// -------------------------------------------------Without Bloc--------------------------------------------------------------
// Container priorityStateController() {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Flex(
//               direction: Axis.horizontal,
//               children: [
//                 Flexible(
//                     flex: 1,
//                     child: PriorityCheckBox(
//                       onTap: () {
//                         setState(() {
//                           widget.task.priority = Priority.high;
//                         });
//                       },
//                       label: 'High',
//                       isSelected: widget.task.priority == Priority.high,
//                       color: primaryColor,
//                     )),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Flexible(
//                     flex: 1,
//                     child: PriorityCheckBox(
//                       onTap: () {
//                         setState(() {
//                           widget.task.priority = Priority.normal;
//                         });
//                       },
//                       label: 'Normal',
//                       isSelected: widget.task.priority == Priority.normal,
//                       color: normalPeriority,
//                     )),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Flexible(
//                     flex: 1,
//                     child: PriorityCheckBox(
//                       onTap: () {
//                         setState(() {
//                           widget.task.priority = Priority.low;
//                         });
//                       },
//                       label: 'Low',
//                       isSelected: widget.task.priority == Priority.low,
//                       color: lowPeriority,
//                     )),
//               ],
//             ),
//             EditTextField(textEditingController: _textEditingController)
//           ],
//         ),
//       ),
//     );
  // -------------------------------------------------With Bloc--------------------------------------------------------------
  Container priorityStateController() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<EditTaskCubit, EditTaskCubitState>(
              builder: (context, state) {
                final priority = state.task.priority;
                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          onTap: () {
                            context
                                .read<EditTaskCubit>()
                                .onPriorityChange(Priority.high);
                          },
                          label: 'High',
                          isSelected: priority == Priority.high,
                          color: primaryColor,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          onTap: () {
                            context
                                .read<EditTaskCubit>()
                                .onPriorityChange(Priority.normal);
                          },
                          label: 'Normal',
                          isSelected: priority == Priority.normal,
                          color: normalPeriority,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        flex: 1,
                        child: PriorityCheckBox(
                          onTap: () {
                            context
                                .read<EditTaskCubit>()
                                .onPriorityChange(Priority.low);
                          },
                          label: 'Low',
                          isSelected: priority == Priority.low,
                          color: lowPeriority,
                        )),
                  ],
                );
              },
            ),
            EditTextField(
              textEditingController: _textEditingController,
            )
          ],
        ),
      ),
    );
  }
}

class EditTextField extends StatelessWidget {
  const EditTextField({
    super.key,
    required TextEditingController textEditingController,
  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: (value) {
        context.read<EditTaskCubit>().onTextChange(value);
      },
      decoration: const InputDecoration(
          label: Text('Add a Task for Today....',
              style: TextStyle(color: secodaryTextColor))),
    );
  }
}
