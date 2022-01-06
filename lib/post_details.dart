import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'models/Post.dart';

class PostDetailsPage extends StatefulWidget {
  Post _post;

  PostDetailsPage({Key? key, required String blogId, Post? post})
      : _post = post ??
            Post(
              title: '',
              body: '',
              blogID: blogId,
            ),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostDetailsPageState(
      postTitle: _post.title,
      postBody: _post.body,
    );
  }
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final TextEditingController _postTitleController;
  final TextEditingController _postBodyController;

  _PostDetailsPageState({required String postTitle, required String postBody})
      : _postTitleController = TextEditingController(text: postTitle),
        _postBodyController = TextEditingController(text: postBody),
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget._post.title.isEmpty ? 'New Post' : widget._post.title,
        ),
      ),
      body: _newPostForm(),
    );
  }

  Widget _newPostForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _postTitleController,
            maxLines: 2,
            decoration: InputDecoration.collapsed(hintText: 'Post title'),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _postBodyController,
              maxLines: 100,
              decoration:
                  InputDecoration.collapsed(hintText: 'Write a blog post...'),
              keyboardType: TextInputType.multiline,
            ),
          ),
          ElevatedButton(
            child: Text('Save Post'),
            onPressed: _savePost,
          )
        ],
      ),
    );
  }

  void _savePost() async {
    final post = widget._post.copyWith(
      title: _postTitleController.text,
      body: _postBodyController.text,
    );

    try {
      await Amplify.DataStore.save(post);
      _showSavedToast();
    } catch (e) {
      print(e);
    }
  }

  void _showSavedToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text('Post Saved'),
      ),
    );
  }
}
