import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sentimento/api/mynetwork_requests.dart';
import 'package:sentimento/models/post_model.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(PostLoading postLoading) : super(PostLoading()) {
    on<ViewPostsClicked>(_viewPostsClicked);
    on<AddPostClicked>(_addPostClicked);
  }

  FutureOr<void> _viewPostsClicked(
      ViewPostsClicked viewPostsClicked, Emitter<PostState> emit) async {
    emit.call(PostLoading());
    //when loading finish, will move to showing user's asked posts
    try {
      PostModel postsResponse = viewPostsClicked.postType == "user"
          ? await requestUserPosts()
          : viewPostsClicked.postType == "vacancy"
              ? await requestAllPosts("vacancy")
              : await requestAllPosts("freelancer");
      postsResponse.success == "true"
          ? emit.call(ViewPostsState(posts: postsResponse.vacancies))
          : emit.call(PostFailedState(message: postsResponse.msg));
    } catch (e) {
      emit.call(PostFailedState(message: "No internet or try again"));
    }
  }

  FutureOr<void> _addPostClicked(
      AddPostClicked addPostClicked, Emitter<PostState> emit) async {
    emit.call(PostLoading());
    try {
      var addPostResponse = await addNewPost(addPostClicked.post);
      addPostResponse["success"] == "true"
          ? emit.call(AddPostState())
          : emit.call(PostFailedState(message: addPostResponse["msg"]));
    } catch (e) {
      emit.call(PostFailedState(message: "No internet or try again"));
    }
  }
}
