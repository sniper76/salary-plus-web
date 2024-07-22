import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_image.freezed.dart';
part 'post_image.g.dart';

@freezed
class PostImage with _$PostImage {
  const factory PostImage({
    required int imageId,
    required String imageUrl,
  }) = _PostImage;

  factory PostImage.fromJson(Map<String, dynamic> json) => _$PostImageFromJson(json);
}
