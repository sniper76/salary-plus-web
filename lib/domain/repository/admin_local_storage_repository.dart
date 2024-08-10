abstract class AdminLocalStorageRepository {
  String? get(String storageKey);

  void save(String storageKey, String data);

  void delete(String storageKey);

  List<String> list();
}
