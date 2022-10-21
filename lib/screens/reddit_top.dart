import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocketx/api.dart';
import 'package:rocketx/bloc/reddit_bloc.dart';
import 'package:rocketx/widgets/reddit_post_item.dart';

class RedditTopTab extends StatefulWidget {
  const RedditTopTab({Key? key}) : super(key: key);

  @override
  State<RedditTopTab> createState() => _RedditTopTabState();
}

class _RedditTopTabState extends State<RedditTopTab> with AutomaticKeepAliveClientMixin<RedditTopTab> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => RedditBloc(
        RepositoryProvider.of<RocketXAPI>(context),
      )..add(LoadRedditTopApiEvent()),
      child: BlocBuilder<RedditBloc, RedditState>(builder: (context, state) {
        if (state is RedditLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is RedditLoadedState) {
          return RefreshIndicator(
            onRefresh: () async {
              return context.read<RedditBloc>().add(LoadRedditTopApiEvent());
            },
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return RedditPostItem(post: state.redditPosts[index]);
                },
                itemCount: state.redditPosts.length),
          );
        }
        if (state is RedditLoadErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Unexpected result...'),
          );
        }
      }),
    );
  }
}
