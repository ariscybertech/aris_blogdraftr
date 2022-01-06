import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  VoidCallback didSignIn;

  AuthView({Key? key, required this.didSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Sign In'),
          onPressed: _signIn,
        ),
      ),
    );
  }

  void _signIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI();
      if (result.isSignedIn == false) return;
      didSignIn();
    } catch (e) {
      print(e);
    }
  }
}
