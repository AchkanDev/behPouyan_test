import 'dart:typed_data';

import 'package:beh_pouyan_test/data/Reopsitory/post_repository.dart';
import 'package:beh_pouyan_test/data/post.dart';

import 'package:beh_pouyan_test/services/upload_to_fireBase.dart';
import 'package:beh_pouyan_test/utils/appExeption.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final IPostRepository postRepository;
  AddPostBloc(this.postRepository) : super(AddPostLoading()) {
    on<AddPostEvent>((event, emit) async {
      if (event is PostImage) {
        try {
          emit(AddPostLoading());
          String downloadUrl = await StorageMethods()
              .uploadImageToFireBase("postsPic", event.image);

          await postRepository.sendPost(Post(downloadUrl, event.caption));
          emit(AddPostSuccess());
        } catch (e) {
          emit(AddPostError(AppException(messageError: e.toString())));
        }
      }
    });
  }
}
