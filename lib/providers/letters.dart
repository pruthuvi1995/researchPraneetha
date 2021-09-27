import 'package:flutter/cupertino.dart';

import '../database.dart';
import 'letter.dart';

class Letters extends ChangeNotifier {
  List<Letter> _letters = [];

  List<Letter> get letters => _letters;

  void removeLetter(Letter letter, Database db) =>
      db.deleteReceiverLetter(letter);

  void setLetters(List<Letter> letters) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _letters = letters;

        notifyListeners();
      });
}
