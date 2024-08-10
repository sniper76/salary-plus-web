import 'package:act_cms/data/datasource/local/local_storage_datasource.dart';
import 'package:act_cms/domain/repository/admin_local_storage_repository.dart';

class AdminLocalStorageRepositoryImpl implements AdminLocalStorageRepository {
  final LocalStorageDataSource dataSource;

  const AdminLocalStorageRepositoryImpl({required this.dataSource});

  @override
  void delete(String storageKey) {
    dataSource.removeFromLocalStorage(storageKey);
  }

  @override
  String? get(String storageKey) {
    return dataSource.readFileDataFromLocalStorage(storageKey);
  }

  @override
  void save(String storageKey, String data) {
    dataSource.saveFileDataToLocalStorage(storageKey, data);
  }

  @override
  List<String> list() => dataSource.readAllFileDataFromLocalStorage();
}
