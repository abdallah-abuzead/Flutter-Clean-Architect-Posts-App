import 'package:clean_architecture_posts_app/features/posts/presentaion/pages/post_details_page.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({Key? key, required this.posts}) : super(key: key);
  final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) {
        return ListTile(
          leading: Text(posts[i].id.toString()),
          title: Text(
            posts[i].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(posts[i].body, style: const TextStyle(fontSize: 16)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PostDetailsPage(post: posts[i])),
            );
          },
        );
      },
      separatorBuilder: (context, i) => const Divider(thickness: 1),
      itemCount: posts.length,
    );
  }
}
