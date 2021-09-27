import 'dart:convert';
import 'dart:io';
import '../../providers/user.dart';

import '../../database.dart';
import '../../models/http_exception.dart';

// import '../providers/auth.dart';

import 'package:flutter/material.dart';
import '../../widgets/default_button.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';

import '../../size_config.dart';
// import 'package:provider/provider.dart';

// import 'package:http/http.dart' as http;

enum RegisterMode { Name, Email, Password, PostBoxNo, Address, Final }

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  RegisterMode _registerMode = RegisterMode.Name;
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

  Map<String, String> _registerData = {
    "firstName": "",
    "lastName": "",
    "email": "",
    "password": "",
    "postBoxNo": "",
    "address": ""
  };
  // String nICNo;
  // String password;

  final _passwordController = TextEditingController();

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
    var errorMsg;
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_registerMode == RegisterMode.Address) {
      try {
        await Provider.of<Auth>(context, listen: false)
            .register(_registerData['email'], _registerData['password']);
      } on HttpException catch (error) {
        var errorMessage =
            'Could no t authenticate you. Please try again later';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'This email address is already in use';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'This is not a valid email';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMessage = 'This password is too weak.';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Could not find a user with thatb email.';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Invalid password';
        } else {
          errorMessage = 'Authentication failed';
        }

        errorMsg = errorMessage;
        _showErrorDialog(errorMessage);
      } catch (error) {
        const errorMessage =
            'Could not authenticate you. Please try again later';
        errorMsg = errorMessage;
        _showErrorDialog(errorMessage);
      }

      try {
        await db.createUserDetails(
          _registerData['address'],
          _registerData['email'],
          _registerData['firstName'],
          _registerData['lastName'],
          _registerData['postBoxNo'],
        );
      } catch (error) {
        const errorMessage =
            'Could not authenticate you. Please try again later';
        errorMsg = errorMessage;
        _showErrorDialog(errorMessage);
      }
    }

    // Provider.of<Auth>(context).user = User(
    //   fName: _registerData['firstName'],
    //   lName: _registerData['lastName'],
    //   email: _registerData['email'],
    //   address: _registerData['address'],
    //   postBoxNo: _registerData['postBoxNo'],
    // );

    setState(() {
      _isLoading = false;
    });
    print(_registerMode);

    _switchAuthMode();
    if (_registerMode == RegisterMode.Final && errorMsg == null) {
      Navigator.popAndPushNamed(context, '/');
    }
  }

  void _switchAuthMode() {
    if (_registerMode == RegisterMode.Name) {
      setState(() {
        _registerMode = RegisterMode.Email;
      });
    } else if (_registerMode == RegisterMode.Email) {
      setState(() {
        _registerMode = RegisterMode.Password;
      });
    } else if (_registerMode == RegisterMode.Password) {
      setState(() {
        _registerMode = RegisterMode.PostBoxNo;
      });
    } else if (_registerMode == RegisterMode.PostBoxNo) {
      setState(() {
        _registerMode = RegisterMode.Address;
      });
    } else if (_registerMode == RegisterMode.Address) {
      setState(() {
        _registerMode = RegisterMode.Final;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              if (_registerMode == RegisterMode.Name)
                Container(
                  child: Text('Enter your first name and last name'),
                ),
              if (_registerMode == RegisterMode.Email)
                Container(
                  child: Text('Enter your email address.'),
                ),
              if (_registerMode == RegisterMode.Password)
                Container(
                  child: Text('Enter password with more than 8 characters.'),
                ),
              if (_registerMode == RegisterMode.PostBoxNo)
                Container(
                  child: Text('Enter password with more than 8 characters.'),
                ),
              if (_registerMode == RegisterMode.Address)
                Container(
                  child: Text('Enter your home address with separating commas'),
                ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              Form(
                  key: _formKey,
                  child: Column(children: [
                    if (_registerMode == RegisterMode.Name)
                      buildFirstNameFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    if (_registerMode == RegisterMode.Name)
                      buildLastNameFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    if (_registerMode == RegisterMode.Email)
                      buildEmailFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    if (_registerMode == RegisterMode.Password)
                      buildPasswordFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    if (_registerMode == RegisterMode.Password)
                      buildConfirmPasswordFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    if (_registerMode == RegisterMode.PostBoxNo)
                      buildPostBoxNoFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    if (_registerMode == RegisterMode.Address)
                      buildAddressFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(30),
                    ),
                    DefaultButton(
                      text: _registerMode == RegisterMode.Final
                          ? 'Try again'
                          : 'Next',
                      press: () => {
                        (_isLoading) ? CircularProgressIndicator() : _submit()
                      },
                    )
                  ])),
            ],
          );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => _registerData['email'] = value,
      decoration: InputDecoration(
        labelText: 'e-mail',
        hintText: 'Enter your e-mail address',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Input your e-mail address';
        }
      },
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.name,
      controller: _passwordController,
      validator: (value) {
        if (value.isEmpty || value.length < 8) {
          return 'Password is too short';
        }
        return null;
      },
      onSaved: (value) => _registerData['password'] = value,
      decoration: InputDecoration(
        labelText: 'password',
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value != _passwordController.text) {
          return 'Password do not match';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Confirm password',
        hintText: 'Confirm your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => _registerData['firstName'] = value,
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'Enter your first name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Input the first name';
        }
      },
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => _registerData['lastName'] = value,
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: 'Enter your last name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Input the last name';
        }
      },
    );
  }

  TextFormField buildPostBoxNoFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => _registerData['postBoxNo'] = value,
      decoration: InputDecoration(
        labelText: 'Post Box No',
        hintText: 'Enter your Post Box No',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Input your post box no';
        }
      },
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (value) => _registerData['address'] = value,
      decoration: InputDecoration(
        labelText: 'Address',
        hintText: 'Enter your home address',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Input your home address';
        }
      },
    );
  }
}
