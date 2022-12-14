import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentaion/widgets/post_datails_page/update_post_btn_widget.dart';
import 'package:flutter/material.dart';

import 'delete_post_btn_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;
  const PostDetailsWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 50),
          Text(
            post.body,
            style: const TextStyle(fontSize: 16),
          ),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!),
            ],
          ),
        ],
      ),
    );
  }
}
