part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

  HomeSuccess(this.snapshot);
}

class HomeError extends HomeState {
  final AppException appException;

  HomeError(this.appException);
}
