import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/file/upload_image_file.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdatePost {
  final PostRepository repository;

  const UpdatePost({required this.repository});

  Future<Result<Post, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required int postId,
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isExclusiveToHolders = false,
    List<UploadImageFile> uploadImages = const [],
    List<Poll>? polls,
  }) {
    return repository.updatePost(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      boardGroupCategory: boardGroupCategory,
      postId: postId,
      title: title,
      content: content,
      isAnonymous: isAnonymous,
      isExclusiveToHolders: isExclusiveToHolders,
      uploadImages: uploadImages,
      polls: polls,
    );
  }
}
