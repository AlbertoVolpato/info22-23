import 'package:flutter/material.dart';
import 'package:flutter_tris_multiplayer/resources/socket_methods.dart';
import 'package:flutter_tris_multiplayer/responsive/responsive.dart';
import 'package:flutter_tris_multiplayer/widgets/custom_button.dart';
import 'package:flutter_tris_multiplayer/widgets/custom_text.dart';
import 'package:flutter_tris_multiplayer/widgets/custom_textfield.dart';
import 'package:flutter_tris_multiplayer/utils/colors.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TicTacToe',
          style: const TextStyle(fontSize: 50),
        ),
        backgroundColor: buttonColor,
        centerTitle: true,
        elevation: 20,
        toolbarHeight: 70,
      ),
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: buttonColor,
                  ),
                ],
                text: 'Entra nella Stanza',
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                controller: _nameController,
                hintText: 'Inserisci un nickname',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _gameIdController,
                hintText: 'Inserisci il Game ID',
              ),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                onTap: () => _socketMethods.joinRoom(
                  _nameController.text,
                  _gameIdController.text,
                ),
                text: 'Entra',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: buttonColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: Offset(4, 8), // Shadow position
            ),
          ],
        ),
        child: (Center(
            child: Text(
          "© Copyright 2022 Alberto Volpato",
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ))),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}
