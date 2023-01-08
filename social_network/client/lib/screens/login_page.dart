import 'dart:convert';

import 'package:client/models/local_user.dart';
import 'package:client/screens/complete_registration.dart';
import 'package:client/screens/screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:client/components/my_button.dart';
import 'package:client/components/my_textfield.dart';
import 'package:client/components/square_tile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:client/screens/home_screen.dart';

import 'package:client/main.dart';
import 'package:http/http.dart' as http;

import '../models/user_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? google_token;

  late List<FullOautInfo> VerifyToken = <FullOautInfo>[];
  FullOautInfo? FullUserInfo;

  // sign user in method
  void signUserIn() {}

  Future<List<FullOautInfo>> fetchByToken(String token) async {
    final response = await http.post(
      Uri.parse('http://2.34.202.83:5000/userbytoken'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'google_token': token,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var parsedPostList = json.decode(response.body);
      parsedPostList.forEach((index) {
        VerifyToken.add(FullOautInfo.fromJson(index));
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
    return VerifyToken;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    clientId:
        '13359980221-62s9pb9ffon3gu0gik6bgk9h43ssvogj.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      final result = await _googleSignIn.signIn();
      final googleAuth = await result!.authentication;
      String g_token = googleAuth.accessToken.toString();
      google_token = g_token;
      await _handleGetFullOautInfo(g_token);
      //print(FullUserInfo!.user_id);
      var user_id_google = FullUserInfo!.user_id;
      user.put('user', user_id_google);
      await fetchByToken(user_id_google);
      try {
        if (VerifyToken[0].user_id != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenController()),
          );
        }
      } catch (error) {
        user.put('user', FullUserInfo!.user_id);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CompleteRegistration()),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<FullOautInfo> _handleGetFullOautInfo(String token) async {
    var parsedOuatFull;
    final response = await http.get(Uri.parse(
        'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=$token'));
    if (response.statusCode == 200) {
      parsedOuatFull = jsonDecode(response.body);
      FullUserInfo = FullOautInfo.fromJson(parsedOuatFull);
      return FullUserInfo!;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
    user.delete('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F6),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: signUserIn,
              ),

              const SizedBox(height: 30),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // google + apple sign in buttons
              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                onPressed: () {
                  _handleSignIn();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Image(
                        image: AssetImage("assets/images/google.png"),
                        height: 35.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
