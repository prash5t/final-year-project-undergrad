part of 'posts_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class ViewPostsClicked extends PostEvent {
  final String postType;
  const ViewPostsClicked({required this.postType});
}

class AddPostClicked extends PostEvent {
  final Vacancy post;
  const AddPostClicked({required this.post});
}

// class ViewFreelancersClicked extends PostEvent {}

// class PostVacancyClicked extends PostEvent {}

// class PostServiceClicked extends PostEvent {}
