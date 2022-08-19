import 'package:clean_architecture_posts_app/core/util/snackbar_message.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentaion/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentaion/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/post.dart';
import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePost extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePost({
    Key? key,
    this.post,
    this.isUpdatePost = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() => AppBar(title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'));

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
          listener: (context, state) {
            if (state is MessageAddDeleteUpdatePostState) {
              SnackBarMessage().showSuccessSnackBar(context: context, message: state.message);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const PostsPage()),
                (route) => false,
              );
            } else if (state is ErrorAddDeleteUpdatePostState) {
              SnackBarMessage().showErrorSnackBar(context: context, message: state.message);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const PostsPage()),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) return const LoadingWidget();
            return FormWidget(post: post);
          },
        ),
      ),
    );
  }
}
