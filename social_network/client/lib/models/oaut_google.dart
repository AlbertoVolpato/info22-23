import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleOaut {
  final GoogleSignIn _googleSignIn = GoogleSignIn(

      // The OAuth client id of your app. This is required.
      clientId:
          '13359980221-62s9pb9ffon3gu0gik6bgk9h43ssvogj.apps.googleusercontent.com',
      // If you need to authenticate to a backend server, specify its OAuth client. This is optional.
      serverClientId: '');

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}
