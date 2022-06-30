part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  PostLoaded({
    required this.postList,
  });

  final List<Post> postList;
}

class PostNoData extends PostState {
  PostNoData(this.message);

  final String message;
}

class PostPermission extends PostState {
  PostPermission(this.message);

  final String message;
}

class PostError extends PostState {
  PostError({
    required this.errorMessage,
  });

  final String errorMessage;
}
