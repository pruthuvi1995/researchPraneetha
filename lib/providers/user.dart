import 'package:flutter/cupertino.dart';

class User {
  final String fName;
  final String lName;
  final String email;
  final String password;
  final String postBoxNo;
  final String address;

  User(
      {@required this.fName,
      @required this.lName,
      @required this.email,
      @required this.password,
      @required this.postBoxNo,
      @required this.address});
}
