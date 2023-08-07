part of 'add_post_bloc.dart';

@immutable
abstract class AddPostEvent {}

class PostImage extends AddPostEvent {
  final Uint8List image;
  final String caption;

  PostImage(this.image, this.caption);
}

class PostStarted extends AddPostEvent {
  PostStarted();
}
