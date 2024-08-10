import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/push/push_search_type.dart';
import 'package:act_cms/domain/model/group_push.dart';
import 'package:act_cms/domain/model/individual_push.dart';
import 'package:act_cms/domain/repository/admin_push_repository.dart';
import 'package:multiple_result/src/result.dart';

class AdminPushRepositoryImpl implements AdminPushRepository {
  final ApiDataSource dataSource;

  const AdminPushRepositoryImpl({required this.dataSource});

  @override
  Future<Result<GroupPush, Exception>> create(
      {required String content,
      String? stockCode,
      required String title,
      int? stockGroupId,
      required String stockTargetType,
      required String sendType,
      String? postId,
      required String linkType,
      DateTime? targetDatetime}) async {
    final data = {
      'title': title,
      'content': content,
      'stockCode': stockCode,
      'stockGroupId': stockGroupId,
      'stockTargetType': stockTargetType,
      'sendType': sendType,
      'postId': postId,
      'linkType': linkType,
      'targetDatetime': targetDatetime?.toUtc().toIso8601String(),
    };
    final res = await safeCall<DataResponse<GroupPush>>(dataSource.createAdminPush(data));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> delete({required int pushId}) {
    return safeCall<void>(dataSource.deleteAdminPush(pushId));
  }

  @override
  Future<Result<DataResponse<List<GroupPush>>, Exception>> list({
    String? searchKeyword,
    required PushSearchType searchType,
    int page = 1,
    int size = 20,
    String? sorts,
  }) {
    return safeCall<DataResponse<List<GroupPush>>>(dataSource.getAdminPushes(
      searchType.value,
      searchKeyword,
      page,
      size,
      sorts,
    ));
  }

  @override
  Future<Result<DataResponse<List<IndividualPush>>, Exception>> individualList({
    String? searchKeyword,
    required String searchType,
    int page = 1,
    int size = 20,
    String? sorts,
  }) {
    return safeCall<DataResponse<List<IndividualPush>>>(dataSource.getAdminIndividualPushes(
      searchType,
      searchKeyword,
      page,
      size,
      sorts,
    ));
  }
}
