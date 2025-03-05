import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud_app/models/post.dart';
import 'package:flutter_crud_app/providers/post_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter CRUD App')),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          return ListView.builder(
            itemCount: postProvider.posts.length,
            itemBuilder: (context, index) {
              final post = postProvider.posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    postProvider.deletePost(post.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add new post
          showDialog(
            context: context,
            builder: (context) {
              return AddPostDialog();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddPostDialog extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: bodyController,
            decoration: InputDecoration(labelText: 'Body'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final newPost = Post(
              id: 0,
              title: titleController.text,
              body: bodyController.text,
            );
            Provider.of<PostProvider>(context, listen: false).createPost(newPost);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
