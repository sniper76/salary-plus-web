import 'package:act_cms/domain/model/post.dart';

class PostDigitalZipItem {
  final Post post;
  final int retryCount;

  PostDigitalZipItem({required this.post, this.retryCount = 0});
}
