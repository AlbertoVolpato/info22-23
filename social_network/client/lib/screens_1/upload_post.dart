import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:client/components/my_textfield.dart';
import 'package:client/models/user_api.dart';
import 'package:client/screens/screen_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mime_type/mime_type.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:http/http.dart' as http;

import '../main.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});
  @override
  _UploadPost createState() => _UploadPost();
}

class _UploadPost extends State<UploadPost> {
  XFile? image;
  File? _file;
  Uint8List? webImage;

  final contentController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  late List<FullOautInfo> VerifyToken = <FullOautInfo>[];

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  Future getImageWeb() async {
    final imageweb = await ImagePickerWeb.getImageAsBytes();
    setState(() {
      webImage = imageweb!;
    });
  }

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

  void _upload() async {
    await fetchByToken(user.get('user'));
    Dio dio = new Dio();

    String fileName = image!.path.split('/').last;

    FormData data = FormData.fromMap({
      "images": await MultipartFile.fromFile(
        image!.path,
        filename: fileName,
      ),
      "content": contentController.text,
      "user_id": VerifyToken[0].user_id,
    });

    await dio.post("http://2.34.202.83:5000/post", data: data).then(
      (response) {
        print(response);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenController()),
        );
      },
    ).catchError((error) {
      errorAllert();
    });
  }

  void _uploadWeb() async {
    await fetchByToken(user.get('user'));
    Dio dio = new Dio();

    String fileName = "png";

    FormData data = FormData.fromMap({
      "images": await MultipartFile.fromBytes(
        webImage!,
        filename: fileName,
      ),
      "content": contentController.text,
      "user_id": VerifyToken[0].user_id,
    });

    await dio.post("http://2.34.202.83:5000/post", data: data).then(
      (response) {
        print(response);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenController()),
        );
      },
    ).catchError((error) {
      errorAllert();
    });
  }

  //show popup dialog
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
                        getImageWeb();
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

  Widget AddPostAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  if (image != null && contentController != null) {
                    _upload();
                  } else if (webImage != null && contentController != null) {
                    _uploadWeb();
                  } else {
                    myCostumAlert();
                  }
                }),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScreenController()),
              );
            }), //automaticallyImplyLeading: false,
        actions: [AddPostAppBar()],
        backgroundColor: Color(0xFFEDF0F6),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: contentController,
                obscureText: false,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Color.fromARGB(255, 200, 200, 200),
                    filled: true,
                    hintText: 'Content',
                    hintStyle: TextStyle(color: Colors.black87)),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  myAlert();
                },
                child: Text('Select Photo'),
              ),
            ),
            SizedBox(height: 15),

            //if image not null show the image
            //if image null show text
            image != null || webImage != null
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: kIsWeb
                                ? Image.memory(
                                    webImage!,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 400,
                                  )
                                : Image.file(
                                    //to show image, you type like this.
                                    File(image!.path),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 400,
                                  )),
                      ),
                    ],
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}
