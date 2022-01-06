import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:blog_drafter/amplifyconfiguration.dart';
import 'package:blog_drafter/auth_view.dart';
import 'package:blog_drafter/blogs_page.dart';
import 'package:blog_drafter/loading_page.dart';
import 'package:blog_drafter/models/ModelProvider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;
  bool? _isUserSignedIn;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isAmplifyConfigured && _isUserSignedIn != null
          ? _isUserSignedIn == true
              ? BlogsPage()
              : AuthView(
                  didSignIn: () {
                    setState(() => _isUserSignedIn = true);
                  },
                )
          : LoadingPage(),
    );
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyAPI(),
        AmplifyDataStore(modelProvider: ModelProvider.instance),
      ]);

      await Amplify.configure(amplifyconfig);
      print('amplify configured');

      setState(() {
        _isAmplifyConfigured = true;
      });

      _checkSignInStatus();
    } catch (e) {
      print(e);
    }
  }

  void _checkSignInStatus() async {
    final session = await Amplify.Auth.fetchAuthSession();
    setState(() {
      _isUserSignedIn = session.isSignedIn;
    });
  }
}
