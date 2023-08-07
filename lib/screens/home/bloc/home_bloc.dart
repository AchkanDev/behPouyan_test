import 'package:beh_pouyan_test/data/Reopsitory/post_repository.dart';
import 'package:beh_pouyan_test/data/post.dart';
import 'package:beh_pouyan_test/utils/appExeption.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IPostRepository postRepository;
  HomeBloc(this.postRepository) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        try {
          emit(HomeLoading());
          final snapshot = await postRepository.getPosts();
          emit(HomeSuccess(snapshot));
        } catch (e) {
          emit(HomeError(AppException(messageError: e.toString())));
        }
      }
    });
  }
}
