import 'package:clean_architecture_posts_app/features/posts/presentaion/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentaion/widgets/post_add_update_page/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import 'form_submit_btn.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key, required this.post}) : super(key: key);
  final Post? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late bool isUpdatePost;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    isUpdatePost = widget.post != null;
    if (isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(controller: _titleController, name: 'Title'),
          TextFormFieldWidget(controller: _bodyController, name: 'Body', multiLine: true),
          FormSubmitBtn(isUpdatePost: isUpdatePost, onPressed: validateFormThenAddOrUpdatePost),
        ],
      ),
    );
  }

  void validateFormThenAddOrUpdatePost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      Post post = Post(
        id: isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );
      if (isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(AddPostEvent(post: post));
      }
    }
  }
}
