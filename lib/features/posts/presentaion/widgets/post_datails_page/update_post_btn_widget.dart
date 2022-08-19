import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';

import '../../pages/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PostAddUpdatePost(post: post)),
        );
      },
      icon: const Icon(Icons.edit),
      label: const Text('Edit'),
    );
  }
}
