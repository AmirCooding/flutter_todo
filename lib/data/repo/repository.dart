// what is difference between Repository and SourceData ?
//The repository decides from which source the data should be received

import 'package:flutter/material.dart';
import 'package:todo/data/source/source.dart';

class Repository<T> extends ChangeNotifier implements DataSource {
  final DataSource<T> localDataSource;

  Repository(this.localDataSource);
  @override
  Future createOrUpdate(data) async {
    final T dataSource = await localDataSource.createOrUpdate(data);
    notifyListeners();
    return dataSource;
  }

  @override
  Future<void> delete(data) async {
    await localDataSource.delete(data);
    notifyListeners();
  }

  @override
  Future<void> deleteAll() async {
    await localDataSource.deleteAll();
    notifyListeners();
  }

  @override
  Future<void> deletebyId(id) async {
    await localDataSource.findById(id);
    notifyListeners();
  }

  @override
  Future<T> findById(id) async {
    return localDataSource.findById(id);
  }

  @override
  Future<List<T>> getAll({String searchKeyword = ''}) {
    return localDataSource.getAll(searchKeyword: searchKeyword);
  }
}
