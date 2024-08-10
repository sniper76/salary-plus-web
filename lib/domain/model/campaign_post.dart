import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign_post.g.dart';

@JsonSerializable()
class CampaignPost extends Equatable {
  final int postId;
  final SimpleStock stock;

  const CampaignPost({
    required this.postId,
    required this.stock,
  });

  factory CampaignPost.fromJson(Map<String, dynamic> json) => _$CampaignPostFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignPostToJson(this);

  @override
  List<Object?> get props => [postId];
}
