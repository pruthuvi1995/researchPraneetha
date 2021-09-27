import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:research_praneetha/providers/letter.dart';
import 'package:research_praneetha/providers/letters.dart';

import '../../Utils.dart';
import '../../database.dart';

class LetterWidget extends StatelessWidget {
  final Letter letter;

  const LetterWidget({
    @required this.letter,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Database db = Database();

    db.initiliase();

    void _showErrorDialog(String title, String msg) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('No')),
                FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      deleteLetter(context, letter, db);
                    },
                    child: Text('OK')),
              ],
            )
          ],
        ),
      );
    }

    return Card(
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          // key: Key(letter.id),
          // actions: [
          //   // IconSlideAction(
          //   //   color: Colors.green,
          //   //   onTap: () => editTodo(context, todo),
          //   //   caption: 'Edit',
          //   //   icon: Icons.edit,
          //   // )
          // ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              caption: 'Delete',
              onTap: () => _showErrorDialog('Did you receive the letter?',
                  'Delete this post from the database'),
              icon: Icons.delete,
            )
          ],
          child: buildLetter(context),
        ),
      ),
    );
  }

  Widget buildLetter(BuildContext context) => GestureDetector(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sender: ${letter.senderMailAddress}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (letter.placeType.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          'Location: ${letter.placeType}',
                          style: TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteLetter(BuildContext context, Letter letter, Database db) {
    final provider = Provider.of<Letters>(context, listen: false);
    provider.removeLetter(letter, db);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  // void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => EditTodoPage(todo: todo),
  //       ),
  //     );
}
