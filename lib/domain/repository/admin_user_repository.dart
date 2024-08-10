import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/user_stock_data.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminUserRepository {
  Future<Result<DataResponse<List<User>>, Exception>> get(
      {String? searchType, String? searchKeyword, int? page, int? size, String? sorts, String? filterType});

  Future<Result<DataResponse<List<CorporationUser>>, Exception>> getCorporations(
      {String? searchType, String? searchKeyword, int? page, int? size, String? sorts});

  Future<Result<User, Exception>> getDetail(int userId);

  Future<Result<User, Exception>> addRole({required int userId, required String roleType});

  Future<Result<User, Exception>> assignAdmin({required int userId});

  Future<Result<DataResponse<CorporationUser>, Exception>> createCorporation(
      {required String corporateNo, required String corporateName});

  Future<Result<DataResponse<CorporationUser>, Exception>> updateCorporation(
      {required String corporateNo, required String corporateName, required int corporateId});

  Future<Result<User, Exception>> assignRevokeAdminUser({required int userId});

  Future<Result<DataResponse<List<UserStockData>>, Exception>> getStocks(
      {required int userId, int? page, int? size, String? sorts});

  Future<Result<DataResponse<List<UserStockData>>, Exception>> getDummyStocks(
      {required int userId, int? page, int? size, String? sorts});

  Future<Result<void, Exception>> withdraw({required String finpongAccessToken});

  Future<Result<User, Exception>> updateUserNickname({required int userId, required String nickname});

  Future<Result<User, Exception>> userMe();

  Future<Result<void, Exception>> deleteCorporation({required int corporationId});

  Future<Result<List<int>, Exception>> downloadConfidential({required int userId});
}
