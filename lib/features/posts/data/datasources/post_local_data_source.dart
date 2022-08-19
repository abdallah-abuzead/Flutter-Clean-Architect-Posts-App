import 'dart:convert';

import 'package:clean_architecture_posts_app/core/error/exception.dart';
import 'package:clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCashedPosts();
  Future<Unit> cashPosts(List<PostModel> postModels);
}

const CASHED_POSTS = 'CASHED_POSTS';

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final SharedPreferences sharedPreferences;
  PostLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cashPosts(List<PostModel> postModels) async {
    List postModelsToJson = postModels.map<Map<String, dynamic>>((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString(CASHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() async {
    final jsonString = sharedPreferences.getString(CASHED_POSTS);
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels =
          decodedJsonData.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCashException();
    }
  }
}
