import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: const Center(
            child: Text(
          'Hi There',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
