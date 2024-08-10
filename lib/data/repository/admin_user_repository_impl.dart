import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/user_stock_data.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdminUserRepositoryImpl implements AdminUserRepository {
  final ApiDataSource dataSource;

  const AdminUserRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<User>>, Exception>> get(
      {String? searchType, String? searchKeyword, int? page, int? size, String? sorts, String? filterType}) {
    return safeCall<DataResponse<List<User>>>(
        dataSource.getAdminUsers(searchType, searchKeyword, page, size, sorts, filterType));
  }

  @override
  Future<Result<DataResponse<List<CorporationUser>>, Exception>> getCorporations(
      {String? searchType, String? searchKeyword, int? page, int? size, String? sorts}) {
    return safeCall<DataResponse<List<CorporationUser>>>(
        dataSource.getAdminCorporation(searchType, searchKeyword, page, size, sorts));
  }

  @override
  Future<Result<User, Exception>> getDetail(int userId) async {
    final res = await safeCall<DataResponse<User>>(dataSource.getAdminDetail(userId));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<DataResponse<CorporationUser>, Exception>> createCorporation(
      {required String corporateNo, required String corporateName}) async {
    final data = {
      'corporateNo': corporateNo,
      'corporateName': corporateName,
    };
    return safeCall<DataResponse<CorporationUser>>(dataSource.createCorporation(data));
  }

  @override
  Future<Result<DataResponse<CorporationUser>, Exception>> updateCorporation(
      {required String corporateNo, required String corporateName, required int corporateId}) async {
    final data = {
      'corporateNo': corporateNo,
      'corporateName': corporateName,
    };
    return safeCall<DataResponse<CorporationUser>>(dataSource.updateCorporation(data, corporateId));
  }

  @override
  Future<Result<User, Exception>> addRole({required userId, required String roleType}) async {
    final data = {
      'roleType': roleType,
    };
    final res = await safeCall<DataResponse<User>>(dataSource.addAdminUserRole(userId, data));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<User, Exception>> assignAdmin({required userId}) async {
    final res = await safeCall<DataResponse<User>>(dataSource.assignAdminUserAdmin(userId));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<User, Exception>> updateUserNickname({required userId, required String nickname}) async {
    final data = {
      'nickname': nickname,
    };
    final res = await safeCall<DataResponse<User>>(dataSource.updateAdminUserNickname(userId, data));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<User, Exception>> assignRevokeAdminUser({required userId}) async {
    final res = await safeCall<DataResponse<User>>(dataSource.assignAdminRevokeAdminUser(userId));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<DataResponse<List<UserStockData>>, Exception>> getStocks(
      {required int userId, int? page, int? size, String? sorts}) async {
    return safeCall<DataResponse<List<UserStockData>>>(dataSource.getAdminUserStocks(userId, page, size, sorts));
  }

  @override
  Future<Result<DataResponse<List<UserStockData>>, Exception>> getDummyStocks(
      {required int userId, int? page, int? size, String? sorts}) async {
    return safeCall<DataResponse<List<UserStockData>>>(dataSource.getAdminUserDummyStocks(userId, page, size, sorts));
  }

  @override
  Future<Result<void, Exception>> withdraw({required String finpongAccessToken}) async {
    return safeCall<void>(dataSource.withdrawAdminUserService(finpongAccessToken));
  }

  @override
  Future<Result<User, Exception>> userMe() async {
    final res = await safeCall<DataResponse<User>>(dataSource.userMe());
    final data = res.tryGetSuccess()?.data;
    return (res.isSuccess() && data != null) ? Result.success(data) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> deleteCorporation({required corporationId}) async {
    return safeCall<void>(dataSource.deleteCorporation(corporationId));
  }

  @override
  Future<Result<List<int>, Exception>> downloadConfidential({required int userId}) async {
    return safeCall<List<int>>(dataSource.downloadConfidential(userId));
  }
}
