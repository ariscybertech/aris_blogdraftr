import 'package:amplify_flutter/amplify.dart';
import 'package:blog_drafter/posts_page.dart';
import 'package:flutter/material.dart';

import 'models/Blog.dart';

class BlogsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BlogsPageState();
  }
}

class _BlogsPageState extends State<BlogsPage> {
  List<Blog> _blogs = [];
  final _newBlogNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getBlogs();
    _observeBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
      ),
      body: _blogsList(),
      floatingActionButton: _newBlogButton(context),
    );
  }

  Widget _blogsList() {
    return ListView.builder(
      itemCount: _blogs.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(_blogs[index].name),
            onTap: () => _showPostsForBlog(_blogs[index]),
          ),
        );
      },
    );
  }

  Widget _newBlogButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _showCreateBlogAlert(context),
    );
  }

  void _getBlogs() async {
    try {
      final blogs = await Amplify.DataStore.query(Blog.classType);
      setState(() {
        _blogs = blogs;
      });
    } catch (e) {
      print(e);
    }
  }

  void _observeBlogs() async {
    Amplify.DataStore.observe(Blog.classType).listen((event) {
      _getBlogs();
    });
  }

  Future<void> _showCreateBlogAlert(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Blog'),
            content: TextField(
              controller: _newBlogNameController,
              decoration: InputDecoration(hintText: 'Enter blog name...'),
            ),
            actions: [
              ElevatedButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                child: Text('Save Blog'),
                onPressed: () {
                  _saveBlog();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void _saveBlog() async {
    try {
      final newBlog = Blog(name: _newBlogNameController.text);
      await Amplify.DataStore.save(newBlog);
      _newBlogNameController.clear();
    } catch (e) {
      print(e);
    }
  }

  void _showPostsForBlog(Blog blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostsPage(blog: blog),
      ),
    );
  }
}
