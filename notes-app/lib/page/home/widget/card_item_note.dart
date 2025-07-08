import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';

class CardItemNote extends StatelessWidget {
  final String title, description;
  final Function() onTap;
  final Function() remove;

  const CardItemNote(
      {Key? key,
      required this.title,
      required this.description,
      required this.onTap,
      required this.remove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: remove,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: secondaryColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(description,
                  style: Theme.of(context).textTheme.subtitle1),
            )
          ],
        ),
      ),
    );
  }
}
