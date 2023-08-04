import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/app/models/task.dart';
import 'package:todo/data/source/source.dart';

class HivetaskDataSource implements DataSource<TaskEntity> {
  final Box<TaskEntity> box;

  HivetaskDataSource(this.box);

  @override
  Future<TaskEntity> createOrUpdate(TaskEntity data) async {
    if (data.isInBox) {
      // Data update
      data.save();
    } else {
      // create new Data
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(TaskEntity data) async {
    return data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deletebyId(id) async {
    return box.delete(id);
  }

  @override
  Future<TaskEntity> findById(id) async {
    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<TaskEntity>> getAll({String searchKeyword = ''}) async {
    if (searchKeyword.isNotEmpty) {
      return box.values
          .where((element) => element.name.contains(searchKeyword))
          .toList();
    }
    return box.values.toList();
  }
}
