part of 'reddit_bloc.dart';

abstract class RedditState {
  const RedditState();
}

class RedditLoadingState extends RedditState {
  List<Object> get props => [];
}

class RedditLoadedState extends RedditState {
  final RedditPostsModel? posts;
  final RedditCommunityModel? community;
  const RedditLoadedState({this.posts, this.community});

  List<RedditPostModel> get redditPosts => posts!.postList;
  RedditCommunityModel get redditCommunity => community!;
}

class RedditLoadErrorState extends RedditState {
  final String message = "There is nothing to show";

  String get errorMessage => message;
}
