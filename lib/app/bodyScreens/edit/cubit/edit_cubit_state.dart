part of 'edit_cubit_cubit.dart';

@immutable
abstract class EditTaskCubitState {
  final TaskEntity task;

  const EditTaskCubitState(this.task);
}

class EditCubitInitial extends EditTaskCubitState {
  const EditCubitInitial(super.task);
}

class EditTaskPriortyOnChange extends EditTaskCubitState {
  const EditTaskPriortyOnChange(super.task);
}
