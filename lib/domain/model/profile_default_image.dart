import 'package:json_annotation/json_annotation.dart';

part 'profile_default_image.g.dart';

@JsonSerializable()
class ProfileDefaultImage {
  final int id;
  final String url;

  const ProfileDefaultImage({required this.id, required this.url});

  factory ProfileDefaultImage.fromJson(Map<String, dynamic> json) => _$ProfileDefaultImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDefaultImageToJson(this);
}
