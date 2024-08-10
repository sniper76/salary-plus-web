import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/push/push_search_type.dart';
import 'package:act_cms/domain/model/group_push.dart';
import 'package:act_cms/domain/model/individual_push.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminPushRepository {
  Future<Result<DataResponse<List<GroupPush>>, Exception>> list({
    String? searchKeyword,
    required PushSearchType searchType,
    int page,
    int size,
    String? sorts,
  });

  Future<Result<DataResponse<List<IndividualPush>>, Exception>> individualList({
    String? searchKeyword,
    required String searchType,
    int page,
    int size,
    String? sorts,
  });

  Future<Result<GroupPush, Exception>> create(
      {required String content,
      required String title,
      String? stockCode,
      int? stockGroupId,
      required String stockTargetType,
      required String sendType,
      String? postId,
      required String linkType,
      DateTime? targetDatetime});

  Future<Result<void, Exception>> delete({required int pushId});
}
