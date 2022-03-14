import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD8),
      body: Stack(
        children: const [
          Image(
            image: AssetImage("assets/png/logo.png"),
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
