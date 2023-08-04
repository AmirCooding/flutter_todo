import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/bodyScreens/Home/bloc/task_list_bloc.dart';

import '../../../main.dart';

class DeleteAllBotton extends StatelessWidget {
  const DeleteAllBotton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color(0xffEAEFF5),
      textColor: secodaryTextColor,
      elevation: 0,
      onPressed: () {
        context.read<TaskListBloc>().add(TaskListDeleteAll());
      },
      child: const Row(
        children: [
          Text('Delete All'),
          SizedBox(
            width: 4,
          ),
          Icon(
            CupertinoIcons.delete_solid,
            size: 18,
          ),
        ],
      ),
    );
  }
}
