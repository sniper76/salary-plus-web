import 'package:act_web/domain/model/post/post.dart';
import 'package:event_bus_plus/event_bus_plus.dart';

class PostCountChangeEvent extends AppEvent {
  @override
  List<Object?> get props => [];
}

class PostChangedEvent extends AppEvent {
  final Post post;

  const PostChangedEvent({required this.post});

  @override
  List<Object?> get props => [];
}
