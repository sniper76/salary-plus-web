import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetPost {
  final AdminPostRepository repository;

  const GetPost({required this.repository});

  Future<Result<DataResponse<Post>, Exception>> call(
      {required String stockCode, required BoardGroupType boardGroupType, required int postId}) {
    return repository.getDetail(stockCode: stockCode, boardGroupType: boardGroupType, postId: postId);
  }
}
