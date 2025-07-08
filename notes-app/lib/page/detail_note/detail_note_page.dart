import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/page/detail_note/content/note_basic_content.dart';
import 'package:notes_app_sqflite/providers/note_providers.dart';
import 'package:notes_app_sqflite/utils/navigator_custom.dart';
import 'package:notes_app_sqflite/utils/state_data.dart';
import 'package:provider/provider.dart';

class DetailNotePage extends StatelessWidget {
  static String routeNamed = '/detail-note';
  DetailNotePage({
    Key? key,
  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    context.read<NotesProviders>().detailNote(id: id);

    return Consumer<NotesProviders>(builder: (context, detail, _) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigation.pop();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded)),
          title: Text(
            detail.stateDetail == StateData.loading
                ? 'Loading...'
                : detail.detailNOte.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/share.png',
                height: 24,
                width: 24,
                color: primaryColor,
              ),
            ),
            IconButton(
                onPressed: () {
                  if (detail.detailNOte.description != _controller.text) {
                    context.read<NotesProviders>().updateNote(
                        id: id,
                        title: detail.detailNOte.title,
                        description: _controller.text);
                  }
                },
                icon: const Icon(Icons.save)),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          children: [
            Text(
              'Sunday, 11 Januari 2023',
              style: Theme.of(context).textTheme.caption,
            ),
            ContentNoteBasic(
              id: id,
              controller: _controller,
              desc: detail.detailNOte.description,
            )
          ],
        ),
      );
    });
  }
}
