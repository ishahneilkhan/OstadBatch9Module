import 'package:flutter/material.dart';
import 'package:flutter_crud_app/models/post.dart';
import 'package:flutter_crud_app/services/api_service.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> get posts => _posts;

  final ApiService apiService;

  PostProvider(this.apiService);

  Future<void> fetchPosts() async {
    _posts = await apiService.fetchPosts();
    notifyListeners();
  }

  Future<void> createPost(Post post) async {
    await apiService.createPost(post);
    _posts.add(post);
    notifyListeners();
  }

  Future<void> updatePost(Post post) async {
    await apiService.updatePost(post);
    int index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index] = post;
      notifyListeners();
    }
  }

  Future<void> deletePost(int id) async {
    await apiService.deletePost(id);
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();
  }
}
