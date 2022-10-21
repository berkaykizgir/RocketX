import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocketx/api.dart';
import 'package:rocketx/bloc/reddit_bloc.dart';
import 'package:rocketx/screens/reddit_hot.dart';
import 'package:rocketx/screens/reddit_top.dart';

class ScreenReddit extends StatelessWidget {
  const ScreenReddit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: BlocProvider(
            create: (context) => RedditBloc(
              RepositoryProvider.of<RocketXAPI>(context),
            )..add(LoadRedditCommunityOwnerEvent()),
            child: BlocBuilder<RedditBloc, RedditState>(
              builder: (context, state) {
                return NestedScrollView(
                  headerSliverBuilder: (context, value) {
                    return [
                      state is RedditLoadedState
                          ? SliverAppBar(
                              expandedHeight: 200,
                              backgroundColor: Colors.black,
                              flexibleSpace: FlexibleSpaceBar(
                                  background: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 90,
                                        child: CachedNetworkImage(
                                          imageUrl: state.community!.bannerImage!,
                                          fit: BoxFit.fitWidth,
                                          placeholder: (context, url) {
                                            return AnimatedContainer(
                                              duration: const Duration(milliseconds: 100),
                                              height: 90,
                                              color: Colors.black,
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 16.0),
                                            child: Text(
                                              state.community!.title!,
                                              style: const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          const Card(
                                            color: Colors.blue,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 32),
                                              child: Text(
                                                "Join",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          "${state.community!.subs!} ${state.community!.title!.split('/')[1]}s   ${state.community!.online!} Online",
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          state.community!.description!,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    left: 16,
                                    top: 44,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(state.community!.iconImage!),
                                    ),
                                  )
                                ],
                              )),
                            )
                          : SliverAppBar(
                              expandedHeight: 200,
                              flexibleSpace: FlexibleSpaceBar(
                                background: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 200,
                                  width: double.infinity,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                      SliverPersistentHeader(
                        floating: false,
                        delegate: _SliverAppBarDelegate(
                          const TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: "Top"),
                              Tab(text: "Hot"),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: const TabBarView(
                    children: [
                      RedditTopTab(),
                      RedditHotTab(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
