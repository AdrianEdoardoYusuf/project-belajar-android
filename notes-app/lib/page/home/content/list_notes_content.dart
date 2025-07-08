import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/page/detail_note/detail_note_page.dart';
import 'package:notes_app_sqflite/page/home/widget/card_item_note.dart';
import 'package:notes_app_sqflite/providers/note_providers.dart';
import 'package:notes_app_sqflite/utils/navigator_custom.dart';
import 'package:notes_app_sqflite/utils/state_data.dart';
import 'package:provider/provider.dart';

class ListNotesContent extends StatelessWidget {
  const ListNotesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          'Your Notes',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<NotesProviders>(builder: (context, note, _) {
          if (note.state == StateData.loading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: const Center(
                child: CupertinoActivityIndicator(
                  radius: 12,
                  color: primaryColor,
                ),
              ),
            );
          } else {
            if (note.dataNote.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Center(
                  child: Text(
                    'not avalaibel data note',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: note.dataNote.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.9),
                itemBuilder: (context, index) => CardItemNote(
                  onTap: () {
                    Navigation.pushPage(
                        route: DetailNotePage.routeNamed,
                        arguments: note.dataNote[index].id);
                  },
                  remove: () {
                    context
                        .read<NotesProviders>()
                        .removeNote(id: note.dataNote[index].id);
                  },
                  description: note.dataNote[index].description,
                  title: note.dataNote[index].title,
                ),
              );
            }
          }
        })
      ],
    );
  }
}
