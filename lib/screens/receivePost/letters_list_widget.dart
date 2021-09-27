import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:research_praneetha/providers/letters.dart';

import 'letter_widget.dart';

class LettersListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Letters>(context);
    final letters = provider.letters;

    return letters.isEmpty
        ? Center(
            child: Text(
              'No letters',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: letters.length,
            itemBuilder: (context, index) {
              final letterItem = letters[index];

              return LetterWidget(letter: letterItem);
            },
          );
  }
}
