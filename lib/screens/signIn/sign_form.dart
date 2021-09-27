import 'package:provider/provider.dart';
import 'package:research_praneetha/providers/user.dart';
import '../../database.dart';
import '../../providers/auth.dart';

import '../../models/http_exception.dart';
// import '../providers/auth.dart';

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../../widgets/default_button.dart';
import '../../widgets/form_error.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  Map<String, String> _loginData = {
    "email": "",
    "password": "",
  };
  // String nICNo;
  // String password;

  var _isLoading = false;

  Database db;
  initialise() {
    db = Database();
    db.initiliase();
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('There is an error.'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                // Navigator.pushNamed(context, SignInScreen.routeName);
              },
              child: Text('OK'))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false)
          .login(_loginData['email'], _loginData['password']);
    } on HttpException catch (error) {
      var errorMessage = 'Could not authenticate you. Please try again later';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      } else {
        errorMessage = 'Authentication failed';
      }

      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }
    var data;

    try {
      data = await db.getUserDetails(_loginData['email'], context);
      print('11111');
      print(data);
    } catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';

      _showErrorDialog(errorMessage);
    }

    // Provider.of<Auth>(context).user = User(
    //   fName: data['firstName'],
    //   lName: data['lastName'],
    //   email: data['email'],
    //   address: data['address'],
    //   postBoxNo: data['postBoxId'],
    // );

    setState(() {
      _isLoading = false;
    });

    // if (errorMessage == null)
    // Navigator.Named(context, SignInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          buildEMailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          FormError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          if (_isLoading)
            CircularProgressIndicator()
          else
            DefaultButton(
              text: 'Login',
              press: () => {_submit()},
            )
        ]));
  }

  TextFormField buildEMailFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => _loginData['email'] = value,
      decoration: InputDecoration(
        labelText: 'e-mail',
        hintText: 'Enter the e-mail address',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value.isEmpty || !value.contains('@')) {
          return 'Input the correct email';
        }
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value.isEmpty || value.length < 8) {
          return 'Password is too short';
        }
      },
      onSaved: (value) => _loginData['password'] = value,
      decoration: InputDecoration(
        labelText: 'password',
        hintText: 'Enter the password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
