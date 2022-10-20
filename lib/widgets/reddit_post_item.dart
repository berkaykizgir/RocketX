import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rocketx/models/reddit_posts.dart';

class RedditPostItem extends StatelessWidget {
  const RedditPostItem({Key? key, required this.post}) : super(key: key);
  final RedditPostModel post;
  Color get color {
    return Color(int.parse("0xFF${post.linkFlairBackgroundColor!.split('#')[1]}"));
  }

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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            post.title!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Card(
                          margin: const EdgeInsets.all(0),
                          color: color,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                            child: Text(
                              post.linkFlairText ?? '',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if ((post.linkFlairText == 'Video' || post.linkFlairText == 'Podcast'))
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: post.thumbnail!,
                                  fit: BoxFit.cover,
                                  height: 360,
                                  width: 480,
                                  placeholder: (context, url) => BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 1),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      height: post.thumbnailHeight!.toDouble(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 48,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!(post.linkFlairText == 'Video' || post.linkFlairText == 'Podcast'))
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: post.thumbnail!,
                            height: post.thumbnailHeight!.toDouble(),
                            width: post.thumbnailWidth!.toDouble(),
                            placeholder: (context, url) => BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 1),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: post.thumbnailHeight!.toDouble(),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: post.thumbnailWidth!.toDouble(),
                              color: Colors.black.withOpacity(0.9),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 2),
                                child: Text(
                                  post.thumbnailClickURL!.split('/')[2],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              )
            ] else ...[
              Text(
                post.title!,
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                margin: const EdgeInsets.all(0),
                color: color,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                  child: Text(
                    post.linkFlairText ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                post.description!,
                maxLines: 3,
                style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey),
              )
            ],
          ],
        ),
      ),
    );
  }
}
