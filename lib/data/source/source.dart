abstract class DataSource<T> {
  // datasource is local or remote?
  // what's the speed of information access?
  // if to be  my datasource a server, it takes Time to
  //etch data frome server, because we use Futur hier
  Future<List<T>> getAll({String searchKeyword});
  Future<T> findById(dynamic id);
  Future<void> delete(T data);
  Future<void> deleteAll();

  Future<void> deletebyId(dynamic id);
  Future<T> createOrUpdate(T data);
}
