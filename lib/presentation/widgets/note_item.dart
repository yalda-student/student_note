import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:animations/animations.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';
import 'package:yalda_students_notes/presentation/screen/edit_note/bloc/editnote_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/edit_note/edit_note_screen.dart';
import 'package:yalda_students_notes/presentation/screen/note/bloc/notelist_bloc.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({Key? key, required this.data}) : super(key: key);

  final NoteModel data;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: true,
      closedColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      transitionType: ContainerTransitionType.fade,
      closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      closedElevation: 0,
      openElevation: 20,
      transitionDuration: const Duration(
          milliseconds: AppConstants.openAnimationDuration),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      openBuilder: (context, openContainer) {
        return BlocProvider<EditNoteBloc>(
          create: (context) =>
              EditNoteBloc(
                  NoteRepository(context.read<AppDatabase>()), widget.data),
          child: const EditNoteScreen(),
        );
      },
      closedBuilder: (context, openContainer) {
        return InkWell(
          onTap: () => openContainer.call(),
          onDoubleTap: () => starNote(),
          child: Container(
              height: 100,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: const EdgeInsets.fromLTRB(2, 12, 2, 0),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Color(widget.data.color).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 0.3),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(widget.data.color),
                    Color(widget.data.color).withOpacity(0.55),
                  ])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.data.title,
                          maxLines: 1,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: Color(0xff010101)),
                        ),
                      ),
                      widget.data.isFavorite
                          ? const Icon(Iconsax.star1,
                          color: Colors.amber, size: 20)
                          : const SizedBox()
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.data.category,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.black54),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(widget.data.createdAt),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.black54),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),);
      },
    );
  }

  void starNote() {
    final note = widget.data;
    context.read<NoteListBloc>().add(
      NoteListStar(
        NoteModel(
            id: note.id,
            title: note.title,
            content: note.content,
            createdAt: note.createdAt,
            color: note.color,
            isFavorite: !note.isFavorite,
            categoryId: note.categoryId),
      ),
    );
  }

}
