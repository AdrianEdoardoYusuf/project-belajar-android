import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/page/home/content/list_banner_widget.dart';
import 'package:notes_app_sqflite/page/home/content/list_menu_quick.dart';
import 'package:notes_app_sqflite/page/home/content/list_notes_content.dart';
import 'package:notes_app_sqflite/page/home/widget/button_home_widget.dart';

class HomePage extends StatelessWidget {
  static String routeNamed = "/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 300,
          leading: Center(
            child: Text(
              'Rainbow Notes',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const BannerImageWidget(),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Quick Note',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const WidgetQuickNote(),
            const ListNotesContent()
          ],
        ),
        floatingActionButton: WidgetButtonHome());
  }
}
