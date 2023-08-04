import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/app/models/task.dart';
import 'package:todo/data/repo/repository.dart';

part 'edit_cubit_state.dart';

class EditTaskCubit extends Cubit<EditTaskCubitState> {
  final TaskEntity _task;
  final Repository<TaskEntity> _repository;
  EditTaskCubit(this._task, this._repository) : super(EditCubitInitial(_task));

  void onSaveChangeKelick() {
    _repository.createOrUpdate(_task);
  }

  void onTextChange(String text) {
    _task.name = text;
  }

  void onPriorityChange(Priority priority) {
    _task.priority = priority;
    emit(EditTaskPriortyOnChange(_task));
  }
}
