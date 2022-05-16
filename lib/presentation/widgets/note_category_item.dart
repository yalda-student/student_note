import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';

class NoteCategoryItem extends StatelessWidget {
  final NoteModel note;

  const NoteCategoryItem({
    Key? key,
    required this.note,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    debugPrint(note.toString());
    return Container(
      width: 170,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(note.color).withOpacity(0.85),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 0.3),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(note.color),
            Color(note.color).withOpacity(0.55),
          ],
        ),
      ),
      child: ExpandablePanel(
        header: Text(
          note.title,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w800,
              fontSize: 19,
              color: theme.colorScheme.secondary),
        ),
        collapsed: Text(
        note.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: theme.colorScheme.secondary),
        ),
        expanded: Text(
          note.content,
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: theme.colorScheme.secondary),
        ),
      ),
    );
  }
}
