import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_document_admin.dart';
import 'package:act_cms/domain/model/digital_proxy_result.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/push_request.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateAdminPost {
  final AdminPostRepository repository;

  const CreateAdminPost({required this.repository});

  Future<Result<Post, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required String title,
    required String content,
    bool isActive = true,
    bool isNotification = false,
    bool isAnonymous = false,
    bool isExclusiveToHolders = false,
    List<UploadImageFile> uploadImages = const [],
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
    DigitalDocumentAdmin? digitalDocument,
    String? activeStartDate,
    String? activeEndDate,
    PushRequest? pushRequest,
    bool? isEscaped,
  }) {
    return repository.create(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      boardGroupCategory: boardGroupCategory,
      title: title,
      content: content,
      isActive: isActive,
      isNotification: isNotification,
      isExclusiveToHolders: isExclusiveToHolders,
      uploadImages: uploadImages,
      polls: polls,
      digitalProxy: digitalProxy,
      digitalDocument: digitalDocument,
      activeEndDate: activeEndDate,
      activeStartDate: activeStartDate,
      pushRequest: pushRequest,
      isEscaped: isEscaped,
    );
  }
}
