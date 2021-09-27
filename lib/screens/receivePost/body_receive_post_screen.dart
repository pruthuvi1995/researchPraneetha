import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:research_praneetha/providers/auth.dart';
import 'package:research_praneetha/providers/letter.dart';
import 'package:research_praneetha/providers/letters.dart';

import '../../constants.dart';
import '../../database.dart';
import '../../size_config.dart';
import 'letters_list_widget.dart';

class BodyReceivePostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final email = Provider.of<Auth>(context).email;
    Database db = Database();

    db.initiliase();
    return StreamBuilder<List<Letter>>(
      stream: db.getReceiverEmails(email, context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final letters = snapshot.data;

              final provider = Provider.of<Letters>(context);
              provider.setLetters(letters);

              return LettersListWidget();
            }
        }
      },
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
