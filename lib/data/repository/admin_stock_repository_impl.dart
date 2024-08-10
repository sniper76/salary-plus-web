import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_application.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/model/stock_group_detail.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/model/stock_summary.dart';
import 'package:act_cms/domain/repository/admin_stock_repository.dart';
import 'package:multiple_result/src/result.dart';

class AdminStockRepositoryImpl implements AdminStockRepository {
  final ApiDataSource dataSource;

  const AdminStockRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<StockGroup>>, Exception>> getGroups(
      {int? stockGroupId, int? page, int? size, String? sorts}) {
    return safeCall<DataResponse<List<StockGroup>>>(dataSource.getAdminStockGroups(stockGroupId, page, size, sorts));
  }

  @override
  Future<Result<DataResponse<List<StockGroup>>, Exception>> getGroupsAutoCompete({String? searchKeyword}) {
    return safeCall<DataResponse<List<StockGroup>>>(dataSource.getAdminStockGroupsAutoCompete(searchKeyword));
  }

  @override
  Future<Result<StockGroupDetail, Exception>> getGroupDetail({required int stockGroupId}) async {
    final res = await safeCall<DataResponse<StockGroupDetail>>(dataSource.getAdminStockGroupDetail(stockGroupId));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<StockGroup, Exception>> updateGroupDetail({
    required int stockGroupId,
    required String name,
    required String description,
    required List<String> stockCodes,
  }) async {
    final data = {'name': name, 'description': description, 'stockCodes': stockCodes};
    final res = await safeCall<DataResponse<StockGroup>>(dataSource.updateAdminStockGroupDetail(stockGroupId, data));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<DataResponse<List<Stock>>, Exception>> get({String? code, int? page, int? size, String? sorts}) {
    return safeCall<DataResponse<List<Stock>>>(dataSource.getAdminStock(code, page, size, sorts));
  }

  @override
  Future<Result<StockDetail, Exception>> getDetail({required String code}) async {
    final res = await safeCall<DataResponse<StockDetail>>(dataSource.getAdminStockDetail(code));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<DataResponse<List<StockSummary>>, Exception>> getStatistics(
      {required String code, required String type, required String periodType, required String period}) {
    return safeCall<DataResponse<List<StockSummary>>>(
        dataSource.getAdminStockStatistics(code, type, periodType, period));
  }

  @override
  Future<Result<DataResponse<List<Stock>>, Exception>> getAutoComplete({String? searchKeyword}) {
    return safeCall<DataResponse<List<Stock>>>(dataSource.getAdminStockAutoComplete(searchKeyword));
  }

  @override
  Future<Result<StockReferenceDate, Exception>> createReferenceDates(
      {required String stockCode, DateTime? date}) async {
    final data = {
      'referenceDate': date?.toFormatString(),
    };
    final res =
        await safeCall<DataResponse<StockReferenceDate>>(dataSource.createAdminStockReferenceDates(stockCode, data));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<StockReferenceDate, Exception>> updateReferenceDate(
      {required int stockReferenceDateId, required String stockCode, DateTime? referenceDate}) async {
    final data = {
      'stockCode': stockCode,
      'referenceDate': referenceDate?.toFormatString(),
    };
    final res = await safeCall<DataResponse<StockReferenceDate>>(
        dataSource.updateAdminStockReferenceDates(stockCode, stockReferenceDateId, data));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<List<int>, Exception>> downloadCsv({required String stockCode}) async {
    final res = await safeCall<List<int>>(dataSource.downloadAdminStockCsv(stockCode));
    final data = res.tryGetSuccess();

    if (res.isSuccess() && data != null) {
      return Result.success(data);
    } else {
      return Result.error(res.tryGetError() ?? Exception('empty data'));
    }
  }

  @override
  Future<Result<StockGroup, Exception>> CreateStockGroup(
      {required String name, String? description, List<String>? stockCodes}) async {
    final data = {
      'name': name,
      'description': description,
      'stockCodes': stockCodes,
    };
    final res = await safeCall<DataResponse<StockGroup>>(dataSource.createAdminStockGroup(data));

    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<DataResponse<List<StockReferenceDate>>, Exception>> getReferenceDates({required String stockCode}) {
    return safeCall<DataResponse<List<StockReferenceDate>>>(dataSource.getAdminStockReferenceDates(stockCode));
  }

  @override
  Future<Result<void, Exception>> deleteReferenceDate({required int referenceDateId, required String stockCode}) {
    return safeCall<void>(dataSource.deleteAdminStockReferenceDates(stockCode, referenceDateId));
  }

  @override
  Future<Result<void, Exception>> addDummyStock(
      {required int userId, required String stockCode, required int stockReferenceDateId}) async {
    final data = {
      'stockCode': stockCode,
      'stockReferenceDateId': stockReferenceDateId,
    };
    final res = await safeCall<void>(dataSource.addDummyStock(userId, data));

    return res.isSuccess() ? const Result.success(null) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> deleteDummyStock({required int userId, required String stockCode}) async {
    final data = {
      'stockCode': stockCode,
    };
    final res = await safeCall<void>(dataSource.deleteDummyStock(userId, data));

    return res.isSuccess() ? const Result.success(null) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> deleteStockGroup({required int stockGroupId}) async {
    return safeCall<DataResponse<void>>(dataSource.deleteAdminStockGroup(stockGroupId));
  }

  @override
  Future<Result<SolidarityLeaderElectionApplication, Exception>> getSolidarityLeaderElectionApplcation(
      {required String stockCode, required int solidarityLeaderElectionId, required int solidarityApplicantId}) async {
    return safeCall<SolidarityLeaderElectionApplication>(
        dataSource.getSolidarityLeaderElectionApplcation(stockCode, solidarityLeaderElectionId, solidarityApplicantId));
  }
}
