import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notes_app_sqflite/design/color_style.dart';

class CardCategoryWidget extends StatelessWidget {
  final Color colorBackground;
  final IconData icon;
  final String title, subtitle;
  const CardCategoryWidget(
      {Key? key,
      required this.colorBackground,
      required this.icon,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: colorBackground, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const Spacer(),
          FittedBox(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle2!,
            ),
          ),
        ],
      ),
    );
  }
}
