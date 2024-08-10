import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_document.dart';
import 'package:act_cms/domain/model/digital_document_download.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/user_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'source_post.g.dart';

@JsonSerializable()
class SourcePost extends Equatable {
  final UserProfile? userProfile;
  final BoardGroupCategory? boardCategory;
  final BoardGroupType? boardGroup;
  final Stock? stock;
  final DigitalDocument? digitalDocument;
  final DigitalDocumentDownload? digitalDocumentDownload;
  final List<Poll>? polls;
  final int id;
  final int boardId;
  final String title;
  final String content;
  final PostStatusType status;
  final int userId;
  final int likeCount;
  final int commentCount;
  final int viewCount;
  final bool isActive;
  final bool isNew;
  final bool liked;
  final bool deleted;
  final bool reported;
  final bool isAuthorAdmin;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? editedAt;

  const SourcePost({
    required this.userProfile,
    this.boardCategory,
    required this.boardGroup,
    this.stock,
    this.digitalDocument,
    this.digitalDocumentDownload,
    this.polls,
    required this.id,
    required this.boardId,
    required this.title,
    required this.content,
    required this.status,
    required this.userId,
    required this.likeCount,
    required this.commentCount,
    required this.viewCount,
    required this.isActive,
    required this.isNew,
    required this.liked,
    required this.deleted,
    required this.reported,
    required this.isAuthorAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.editedAt,
  });

  factory SourcePost.fromJson(Map<String, dynamic> json) => _$SourcePostFromJson(json);

  Map<String, dynamic> toJson() => _$SourcePostToJson(this);

  @override
  List<Object?> get props => [id, title, createdAt, updatedAt, status, digitalDocumentDownload];
}
