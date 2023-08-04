import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/bodyScreens/Home/bloc/error.dart';
import 'package:todo/app/bodyScreens/Home/bloc/task_list_bloc.dart';
import 'package:todo/app/bodyScreens/Home/emptyState.dart';
import 'package:todo/app/bodyScreens/Home/listOfTasks.dart';
import 'package:todo/app/bodyScreens/edit/cubit/edit_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/bodyScreens/edit/editTaskScree.dart';
import 'package:todo/app/headerScreens/appBarScreen.dart';
import 'package:todo/app/models/task.dart';
import 'package:todo/data/repo/repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          // --------------without Bloc-------------------------
          // onPressed: () {
          //   Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => EditTaskScreen(
          //             task: TaskEntity(),
          //           )));
          // },

          //---------------------------With Bloc----------------------

          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider<EditTaskCubit>(
                create: (context) => EditTaskCubit(
                    TaskEntity(), context.read<Repository<TaskEntity>>()),
                child: const EditTaskScreen(),
              ),
            ));
          },

          label: const Text('Add new Task'),
          icon: const Icon(CupertinoIcons.add_circled_solid),
        ),
        body: BlocProvider<TaskListBloc>(
          create: (context) =>
              TaskListBloc(context.read<Repository<TaskEntity>>()),
          child: SafeArea(
            child: Column(children: [
              AppBarScreen(
                themeData: themeData,
                lable: Text(
                  'To Do List',
                  style: themeData.textTheme.titleLarge,
                ),
              ),
              Expanded(child: Consumer<Repository<TaskEntity>>(
                builder: (context, model, child) {
                  context.read<TaskListBloc>().add(TaskListStart());
                  return BlocBuilder<TaskListBloc, TaskListState>(
                    builder: (context, state) {
                      if (state is TaskListSuccess) {
                        return TaskList(
                            items: state.items, themeData: themeData);
                      } else if (state is TaskListLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TaskListEmpty) {
                        return const EmptyState();
                      } else if (state is DeleteTaskError) {
                        return MyError(error: state.error);
                      } else {
                        return const MyError(
                          error: 'state is not valid.........',
                        );
                      }
                    },
                  );
                },
              )),
            ]),
          ),
        ));
  }
}
