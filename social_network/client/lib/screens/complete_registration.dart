import 'dart:convert';
import 'dart:io';

import 'package:client/screens/screen_controller.dart';
import 'package:client/utils/server_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:client/components/my_textfield.dart';
import 'package:client/models/user_api.dart';

import 'package:client/main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CompleteRegistration extends StatefulWidget {
  const CompleteRegistration({super.key});

  @override
  State<CompleteRegistration> createState() => _CompleteRegistration();
}

class _CompleteRegistration extends State<CompleteRegistration> {
  // text editing controllers
  final usernameController = TextEditingController();
  XFile? image;
  Uint8List? webImage;
  late List<Username> _user;
  final ImagePicker picker = ImagePicker();
  bool ShowProgress = false;

  Future<void> getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  Future getImageWeb(ImageSource media) async {
    setState(() {
      ShowProgress = true;
    });
    //final imageweb = await ImagePickerWeb.getImageAsBytes();
    final imageweb = await picker.pickImage(source: ImageSource.gallery);
    var f = await imageweb!.readAsBytes();
    setState(() {
      webImage = f;
      ShowProgress = false;
    });
  }

  Future<void> fetchUsername(username) async {
    setState(() {
      ShowProgress = true;
    });
    final response = await http.get(
      Uri.parse(ServerUrl + '/username/' + username),
    );
    setState(() {
      ShowProgress = false;
    });
    if (response.statusCode == 200) {
      // If the server did rturn a 200 OK response,
      // then parse the JSON.
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
    setState(() {
      ShowProgress = true;
    });
    Dio dio = new Dio();
    var google_token = await user.get('user');
    if (image != null) {
      String fileName = image!.path.split('/').last;
      FormData data = FormData.fromMap({
        "picture": await MultipartFile.fromFile(
          image!.path,
          filename: fileName,
        ),
        "username": username,
        "google_token": google_token,
      });
      await dio.post(ServerUrl + "/user", data: data).then(
        (response) {
          print(response);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenController()),
          );
        },
      ).catchError((error) {
        print(error);
        errorAllert();
      });
      setState(() {
        ShowProgress = false;
      });
    } else {
      FormData data = FormData.fromMap({
        "username": username,
        "google_token": google_token,
      });
      await dio.post(ServerUrl + "/user", data: data).then(
        (response) {
          print(response);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenController()),
          );
        },
      ).catchError((error) {
        print(error);
        errorAllert();
      });
    }
  }

  void _uploadWeb(username) async {
    setState(() {
      ShowProgress = true;
    });
    Dio dio = new Dio();
    var google_token = await user.get('user');
    if (webImage != null) {
      String fileName = "png";
      FormData data = FormData.fromMap({
        "picture": await MultipartFile.fromBytes(
          webImage!,
          filename: fileName,
        ),
        "username": username,
        "google_token": google_token,
      });
      await dio.post(ServerUrl + "/user", data: data).then(
        (response) {
          print(response);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenController()),
          );
        },
      ).catchError((error) {
        print(error);
        errorAllert();
      });
      setState(() {
        ShowProgress = false;
      });
    } else {
      setState(() {
        ShowProgress = true;
      });
      FormData data = FormData.fromMap({
        "username": username,
        "google_token": google_token,
      });
      await dio.post(ServerUrl + "/user", data: data).then(
        (response) {
          print(response);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenController()),
          );
        },
      ).catchError((error) {
        print(error);
        errorAllert();
      });
      setState(() {
        ShowProgress = false;
      });
    }
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
              child: kIsWeb
                  ? ElevatedButton(
                      //if user click this button, user can upload image from gallery
                      onPressed: () {
                        Navigator.pop(context);
                        getImageWeb(ImageSource.gallery);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.image),
                          Text('From Gallery'),
                        ],
                      ),
                    )
                  : Column(
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

  void myCostumAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please select an image and inser a text'),
          );
        });
  }

  void errorAllert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('error'),
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
                      child: image == null && webImage == null
                          ? ClipOval(
                              child: Image.asset('assets/images/profile.png'))
                          : kIsWeb
                              ? ClipOval(
                                  child: Image.memory(webImage!),
                                )
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
                  if (image != null && usernameController.text != null) {
                    _upload(usernameController.text.toLowerCase());
                  } else if (webImage != null &&
                      usernameController.text != null) {
                    _uploadWeb(usernameController.text.toLowerCase());
                  } else {
                    myCostumAlert();
                  }
                },
                child: ShowProgress
                    ? CircularProgressIndicator()
                    : Padding(
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
