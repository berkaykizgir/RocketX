part of 'reddit_bloc.dart';

abstract class RedditEvent {
  const RedditEvent();
}

class LoadRedditTopApiEvent extends RedditEvent {
  List<Object> get props => [];
}

class LoadRedditHotApiEvent extends RedditEvent {
  List<Object> get props => [];
}

class LoadRedditCommunityOwnerEvent extends RedditEvent {
  List<Object> get props => [];
}
