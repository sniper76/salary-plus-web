// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html' as html;

import 'package:act_web/core/exception/cache_exception.dart';
import 'package:act_web/domain/model/ranking/ranking_stock.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // Ranking Stock List
  Future<List<RankingStock>?> readRankingStockListFromLocalStorage(String sorts) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('ranking_stock_list_key_$sorts');

    if (jsonList != null) {
      return jsonList.map((jsonString) => RankingStock.fromJson(jsonDecode(jsonString))).toList();
    } else {
      throw CacheException('No Ranking Stock List In Local Storage');
    }
  }

  Future<void> saveRankingStockListToLocalStorage(List<RankingStock> rankingStockList, String sorts) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonSerializedList = rankingStockList.map((stock) => jsonEncode(stock.toJson())).toList();
    prefs.setStringList('ranking_stock_list_key_$sorts', jsonSerializedList);
    prefs.setString('ranking_stock_list_cache_time_$sorts', DateTime.now().toIso8601String());
  }

  Future<DateTime?> getLastRankingStockListCacheTime(String sorts) async {
    final prefs = await SharedPreferences.getInstance();
    String? cacheTimeString = prefs.getString('ranking_stock_list_cache_time_$sorts');
    if (cacheTimeString != null) {
      return DateTime.parse(cacheTimeString);
    } else {
      return null;
    }
  }

  void removeRankingStockListFromLocalStorage(String sorts) {
    html.window.localStorage.remove('ranking_stock_list_key_$sorts');
    html.window.localStorage.remove('ranking_stock_list_cache_time_$sorts');
  }
}
