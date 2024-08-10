import 'package:act_cms/domain/model/campaign_post.dart';
import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:act_cms/domain/model/source_post.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign extends Equatable {
  final int id;
  final String title;
  final int sourceStockGroupId;
  final String sourceStockGroupName;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  final DateTime? deletedAt;
  final bool? isDigitalDocument;
  final bool? isPoll;
  final int? joinStockCount;
  final int? joinUserCount;
  final int? mappedStocksCount;
  final int? stockQuantity;
  final int? sourcePostId;
  final DateTime? targetEndDate;
  final BoardCategoryType? boardCategory;
  final SourcePost? sourcePost;
  final List<CampaignPost>? campaignPosts;

  const Campaign({
    required this.id,
    required this.title,
    required this.sourceStockGroupId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.sourceStockGroupName,
    this.deletedAt,
    this.isDigitalDocument = false,
    this.isPoll = false,
    this.joinStockCount = 0,
    this.joinUserCount = 0,
    this.mappedStocksCount = 0,
    this.stockQuantity = 0,
    this.sourcePostId,
    this.targetEndDate,
    this.boardCategory = BoardCategoryType.all,
    this.sourcePost,
    this.campaignPosts = const [],
  });

  factory Campaign.fromJson(Map<String, dynamic> json) => _$CampaignFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        updatedAt,
        deletedAt,
        status,
        sourceStockGroupId,
        boardCategory,
        stockQuantity,
        sourceStockGroupName
      ];
}
