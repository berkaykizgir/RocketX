import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocketx/api.dart';
import 'package:rocketx/models/reddit_community.dart';
import 'package:rocketx/models/reddit_posts.dart';
part 'reddit_event.dart';
part 'reddit_state.dart';

class RedditBloc extends Bloc<RedditEvent, RedditState> {
  final RocketXAPI _redditApiServices;

  RedditBloc(this._redditApiServices) : super(RedditLoadingState()) {
    on<LoadRedditTopApiEvent>((eventt, emit) async {
      emit(RedditLoadingState());
      final response = await _redditApiServices.getRedditPosts('20', 'flutterdev', 'top');
      emit(RedditLoadedState(posts: response));
    });
    on<LoadRedditHotApiEvent>((eventt, emit) async {
      emit(RedditLoadingState());
      final response = await _redditApiServices.getRedditPosts('20', 'flutterdev', 'hot');
      if (response.postList.isNotEmpty) {
        emit(RedditLoadedState(posts: response));
      } else {
        emit(RedditLoadErrorState());
      }
    });
    on<LoadRedditCommunityOwnerEvent>((eventt, emit) async {
      emit(RedditLoadingState());
      final response = await _redditApiServices.getRedditCommunityOwner('20', 'flutterdev');
      if (response.title != null) {
        emit(RedditLoadedState(community: response));
      } else {
        emit(RedditLoadErrorState());
      }
    });
  }
}
