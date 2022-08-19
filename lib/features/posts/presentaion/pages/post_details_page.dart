import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';

import '../widgets/post_datails_page/post_details_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Post Details'));

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailsWidget(post: post),
      ),
    );
  }
}
