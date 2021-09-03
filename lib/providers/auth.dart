import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> register(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAMajLZXHrh6KtHCPm6ZMPW3s6bq2TJ99c';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);
      print('111111222222222221');

      if (responseData['error'] != null) {
        print(responseData['error']['message']);
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAMajLZXHrh6KtHCPm6ZMPW3s6bq2TJ99c';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addUserDetails(String fName, String lName, String email,
      String postBoxNo, String address) async {
    const url =
        'https://researchpraneetha-default-rtdb.firebaseio.com/userDetails.json';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'fName': fName,
        'lName': lName,
        'email': email,
        'postBoxNo': postBoxNo,
        'address': address,
      }),
    );
    print(json.decode(response.body));
  }
}
