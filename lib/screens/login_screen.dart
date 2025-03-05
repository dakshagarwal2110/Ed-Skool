import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_size.dart';
import 'my_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff01012d),

        body: SafeArea(child: MyForm()),
      ),
    );
  }


}
