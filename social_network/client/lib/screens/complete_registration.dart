import 'dart:convert';
import 'dart:io';

import 'package:client/models/local_user.dart';
import 'package:client/screens/screen_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:client/components/my_button.dart';
import 'package:client/components/my_textfield.dart';
import 'package:client/components/square_tile.dart';
import 'package:client/models/user_api.dart';

import 'package:client/main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CompleteRegistration extends StatefulWidget {
  const CompleteRegistration({super.key});

  @override
  State<CompleteRegistration> createState() => _CompleteRegistration();
}

class _CompleteRegistration extends State<CompleteRegistration> {
  // text editing controllers
  final usernameController = TextEditingController();
  XFile? image;
  late List<Username> _user;
  final ImagePicker picker = ImagePicker();

  //Future<void> getImage() async {
  //  if (!kIsWeb) {
  //    final ImagePicker picker = ImagePicker();
  //    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
  //    if (pickedFile != null) {
  //      var selected = File(pickedFile.path);
  //      setState(() {
  //        _image = selected;
  //      });
  //    }
  //  } else if (kIsWeb) {
  //    final ImagePicker picker = ImagePicker();
  //    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
  //    if (pickedFile != null) {
  //      var f = await pickedFile.readAsBytes();
//
  //      setState(() {
  //        webImage = f;
  //      });
  //    }
  //  }
  //}

  Future<void> getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  Future<void> fetchUsername(username) async {
    final response = await http
        .get(Uri.parse('http://2.34.202.83:5000/username/' + username));

    if (response.statusCode == 200) {
      // If the server did rturn a 200 OK response,
      // then parse the JSON.
      print(response.body);

      var usernameList = json.decode(response.body);
      usernameList.forEach((index) {
        _user.add(Username.fromJson(index));
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void _upload(username) async {
    Dio dio = new Dio();
    var google_token = await user.get('user');
    String fileName = image!.path.split('/').last;
    FormData data = FormData.fromMap({
      "picture": await MultipartFile.fromFile(
        image!.path,
        filename: fileName,
      ),
      "username": username,
      "google_token": google_token,
    });

    await dio.post("http://2.34.202.83:5000/user", data: data).then(
      (response) {
        print(response);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenController()),
        );
      },
    ).catchError((error) => print(error));
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
              const SizedBox(height: 100),
              // logo
              Text(
                'Complete your registration',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),

              InkWell(
                onTap: myAlert,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100.0,
                  child: CircleAvatar(
                      radius: 100.0 - 5,
                      backgroundColor: Colors.white,
                      child: image == null
                          ? ClipOval(
                              child: Image.asset('assets/images/profile.png'))
                          : ClipOval(child: Image.file(File(image!.path)))),
                ),
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'Insert your new Username',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 20),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 150),

              OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                onPressed: () {
                  _upload(usernameController.text.toLowerCase());
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
