import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_application.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/model/stock_group_detail.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/model/stock_summary.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminStockRepository {
  Future<Result<DataResponse<List<StockGroup>>, Exception>> getGroups({
    int? stockGroupId,
    int? page,
    int? size,
    String? sorts,
  });

  Future<Result<DataResponse<List<StockGroup>>, Exception>> getGroupsAutoCompete({String? searchKeyword});

  Future<Result<StockGroupDetail, Exception>> getGroupDetail({required int stockGroupId});

  Future<Result<StockGroup, Exception>> updateGroupDetail(
      {required int stockGroupId, required String name, required String description, required List<String> stockCodes});

  Future<Result<DataResponse<List<Stock>>, Exception>> get({String? code, int? page, int? size, String? sorts});

  Future<Result<StockDetail, Exception>> getDetail({required String code});

  Future<Result<void, Exception>> deleteStockGroup({required int stockGroupId});

  Future<Result<DataResponse<List<StockSummary>>, Exception>> getStatistics(
      {required String code, required String type, required String periodType, required String period});

  Future<Result<DataResponse<List<Stock>>, Exception>> getAutoComplete({String? searchKeyword});

  Future<Result<StockReferenceDate, Exception>> createReferenceDates({required String stockCode, DateTime? date});

  Future<Result<StockReferenceDate, Exception>> updateReferenceDate(
      {required int stockReferenceDateId, required String stockCode, DateTime? referenceDate});

  Future<Result<List<int>, Exception>> downloadCsv({required String stockCode});

  Future<Result<StockGroup, Exception>> CreateStockGroup(
      {required String name, String? description, List<String>? stockCodes});

  Future<Result<DataResponse<List<StockReferenceDate>>, Exception>> getReferenceDates({required String stockCode});

  Future<Result<void, Exception>> deleteReferenceDate({required int referenceDateId, required String stockCode});

  Future<Result<void, Exception>> addDummyStock(
      {required int userId, required String stockCode, required int stockReferenceDateId});

  Future<Result<void, Exception>> deleteDummyStock({required int userId, required String stockCode});

  Future<Result<SolidarityLeaderElectionApplication, Exception>> getSolidarityLeaderElectionApplcation(
      {required String stockCode, required int solidarityLeaderElectionId, required int solidarityApplicantId});
}
