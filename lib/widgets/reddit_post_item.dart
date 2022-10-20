import 'package:flutter/material.dart';
import 'package:rocketx/models/reddit_posts.dart';

class RedditPostItem extends StatelessWidget {
  const RedditPostItem({Key? key, required this.post}) : super(key: key);
  final RedditPostModel post;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Posted by u/${post.authorName ?? ''} ${post.createdUTC}",
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                      size: 16,
                    )),
              ],
            ),
            if (post.thumbnailClickURL != null) ...[
              const Text("data"),
              const Text("data")
            ] else ...[
              Text(
                post.title!,
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ],
        ),
      ),
    );
  }
}
