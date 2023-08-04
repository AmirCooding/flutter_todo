import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/bodyScreens/Home/bloc/task_list_bloc.dart';
import 'package:todo/main.dart';

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({
    super.key,
    required this.themeData,
    required this.lable,
  });

  final ThemeData themeData;
  final Text lable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          themeData.colorScheme.primary,
          themeData.colorScheme.primaryContainer
        ]),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Row(
              children: [
                Expanded(child: lable),
                Icon(
                  CupertinoIcons.share,
                  color: themeData.colorScheme.onPrimary,
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))
            ]),
            margin: marginScreen,
            height: 38,
            width: double.infinity,
            child: SerchField(themeData: themeData),
          ),
        ],
      ),
    );
  }
}

class SerchField extends StatefulWidget {
  const SerchField({
    super.key,
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  State<SerchField> createState() => _SerchFieldState();
}

final TextEditingController textController = TextEditingController();

class _SerchFieldState extends State<SerchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        setState(() {
          context.read<TaskListBloc>().add(TaskListSearch(value));
        });
      },
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: widget.themeData.inputDecorationTheme.iconColor,
        ),
        hintStyle: widget.themeData.inputDecorationTheme.labelStyle,
        hintText: 'Search Task....',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(19),
        ),
      ),
    );
  }
}
