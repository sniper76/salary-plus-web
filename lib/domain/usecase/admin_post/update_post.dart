import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdatePost {
  final AdminPostRepository repository;

  const UpdatePost({required this.repository});

  Future<Result<Post, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required int postId,
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isNotification = false,
    bool isActive = true,
    bool isExclusiveToHolders = false,
    List<UploadImageFile> uploadImages = const [],
    List<int>? pollIds,
    DateTime? pollTargetEndDate,
    DateTime? digitalProxyTargetEndDate,
    DateTime? digitalDocumentTargetEndDate,
    String? activeStartDate,
    String? activeEndDate,
    bool? isEscaped,
  }) {
    return repository.update(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      boardGroupCategory: boardGroupCategory,
      postId: postId,
      title: title,
      content: content,
      isAnonymous: isAnonymous,
      isExclusiveToHolders: isExclusiveToHolders,
      uploadImages: uploadImages,
      pollIds: pollIds,
      pollTargetEndDate: pollTargetEndDate,
      digitalProxyTargetEndDate: digitalProxyTargetEndDate,
      digitalDocumentTargetEndDate: digitalDocumentTargetEndDate,
      isNotification: isNotification,
      isActive: isActive,
      activeEndDate: activeEndDate,
      activeStartDate: activeStartDate,
      isEscaped: isEscaped,
    );
  }
}
