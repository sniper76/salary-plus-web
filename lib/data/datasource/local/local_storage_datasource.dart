import 'dart:html' as html;

class LocalStorageDataSource {
  String? readFileDataFromLocalStorage(String storageKey) {
    return html.window.localStorage[storageKey];
  }

  List<String> readAllFileDataFromLocalStorage() => html.window.localStorage.values.toList();

  void saveFileDataToLocalStorage(String storageKey, String fileData) {
    html.window.localStorage[storageKey] = fileData;
  }

  void removeFromLocalStorage(String storageKey) {
    html.window.localStorage.remove(storageKey);
  }
}
