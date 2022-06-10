part of 'posts_bloc.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {}

class PostFailedState extends PostState {
  final String? message;
  PostFailedState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ViewPostsState extends PostState {
  final List<Vacancy>? posts;
  ViewPostsState({required this.posts});
  @override
  List<Object?> get props => [posts];
}

// class ViewVacancies extends PostState {}

// class ViewFreelancers extends PostState {}

class AddPostState extends PostState {}

// class PostService extends PostState {}
