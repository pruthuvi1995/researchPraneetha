// import '../screens/register_screen.dart';
import 'package:flutter/material.dart';
import '../register/register_screen.dart';

import '../../constants.dart';
import '../../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: getProportionateScreenWidth(300),
        child: Text(
          'Don\'t you have an account? Click the Register to create an account.',
          softWrap: true,
          style: TextStyle(fontSize: getProportionateScreenWidth(12.5)),
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(20),
      ),
      GestureDetector(
        onTap: () => {Navigator.pushNamed(context, RegisterScreen.routeName)},
        child: Text(
          'Register',
          style: TextStyle(
            fontSize: getProportionateScreenHeight(25),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]);
  }
}
