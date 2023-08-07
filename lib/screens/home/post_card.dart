import 'package:beh_pouyan_test/data/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 40,
              height: 40,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: post.downloadUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            const Icon(Icons.more_vert),
          ]),
        ),
        SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            // height: 500,
            child: CachedNetworkImage(
              imageUrl: post.downloadUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: Theme.of(context).colorScheme.shadow)),
            child: Text(
              post.caption,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        )
      ]),
    );
  }
}
