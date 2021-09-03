import '../../constants.dart';
import '../../size_config.dart';
import './register_form.dart';

import 'package:flutter/material.dart';

class BodyRegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                'Welcome',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(40),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Enter your following details',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenHeight(20),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionateScreenHeight(70)),
              RegisterForm(),
            ]),
          ),
        ),
      ),
    );
  }
}
