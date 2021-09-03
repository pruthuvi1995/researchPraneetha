import '../../constants.dart';
import '../../size_config.dart';

import 'package:flutter/material.dart';

import 'body_register_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
//  String language = 'Sinhala'
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenHeight(20),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: BodyRegisterScreen(),
    );
  }
}
