part of 'add_post_bloc.dart';

@immutable
abstract class AddPostState {}

// class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostSuccess extends AddPostState {}

class AddPostError extends AddPostState {
  final AppException appException;

  AddPostError(this.appException);
}
