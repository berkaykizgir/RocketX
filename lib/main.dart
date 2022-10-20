import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rocketx/api.dart';
import 'package:rocketx/models/reddit_posts.dart';
import 'package:rocketx/widgets/reddit_post_item.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RedditPostsModel _getPostsResponse = RedditPostsModel({});
  List<RedditPostModel> _posts = [];

  Future<List<RedditPostModel>> getPosts() async {
    _getPostsResponse = await RocketXAPI.reddit().getRedditPosts('20', 'flutterdev', 'top');
    setState(() {
      _posts = _getPostsResponse.postList;
    });
    return _posts;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      title: 'RocketX',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        appBar: AppBar(
          title: const Text('RocketX'),
        ),
        body: FutureBuilder(
            future: getPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return RedditPostItem(post: snapshot.data![index]);
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
