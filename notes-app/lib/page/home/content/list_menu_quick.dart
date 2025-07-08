import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/page/home/widget/card_quick_widget.dart';

class WidgetQuickNote extends StatelessWidget {
  const WidgetQuickNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const CardCategoryWidget(
            colorBackground: secondaryColor,
            icon: Icons.camera,
            subtitle: 'Capture with camera',
            title: 'turn on your camera into note',
          ),
          const SizedBox(
            width: 16,
          ),
          CardCategoryWidget(
            colorBackground: primaryColor.withOpacity(0.5),
            icon: Icons.draw_rounded,
            subtitle: 'Note the use of drawing lines',
            title: 'Draw your note',
          ),
        ],
      ),
    );
  }
}
