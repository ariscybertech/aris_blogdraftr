import 'package:amplify_flutter/amplify.dart';
import 'package:blog_drafter/models/ModelProvider.dart';
import 'package:blog_drafter/models/Post.dart';
import 'package:blog_drafter/post_details.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  Blog _blog;

  PostsPage({Key? key, required Blog blog})
      : _blog = blog,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PostsPageState();
  }
}

class _PostsPageState extends State<PostsPage> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _getPosts();
    _observePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._blog.name),
      ),
      body: _postsList(),
      floatingActionButton: _newPostButton(),
    );
  }

  Widget _postsList() {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(_posts[index].title),
            subtitle: Text(
              _posts[index].body,
              maxLines: 3,
            ),
            onTap: () => _openPost(post: _posts[index]),
          ),
        );
      },
    );
  }

  Widget _newPostButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _openPost(),
    );
  }

  void _getPosts() async {
    try {
      final posts = await Amplify.DataStore.query(
        Post.classType,
        where: Post.BLOGID.eq(widget._blog.id),
      );
      setState(() {
        _posts = posts;
      });
    } catch (e) {
      print(e);
    }
  }

  void _observePosts() {
    Amplify.DataStore.observe(Post.classType).listen((event) {
      _getPosts();
    });
  }

  void _openPost({Post? post}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailsPage(
          blogId: widget._blog.id,
          post: post,
        ),
      ),
    );
  }
}
