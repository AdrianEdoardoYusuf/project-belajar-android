import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_sqflite/design/color_style.dart';
import 'package:notes_app_sqflite/widgets/dialog_custom.dart';

class WidgetButtonHome extends StatefulWidget {
  WidgetButtonHome({Key? key}) : super(key: key);

  @override
  State<WidgetButtonHome> createState() => _WidgetButtonHomeState();
}

class _WidgetButtonHomeState extends State<WidgetButtonHome>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controllerTitle = TextEditingController();
  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      iconData: Icons.category_outlined,
      items: [
        Bubble(
          title: "Tambah Kategori",
          iconColor: Colors.white,
          bubbleColor: primaryColor,
          icon: Icons.apps_rounded,
          titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
          onPress: () {
            _animationController!.reverse();
          },
        ),
        //Floating action menu item
        Bubble(
          title: "Tambah Catatan",
          iconColor: Colors.white,
          bubbleColor: primaryColor,
          icon: Icons.playlist_add,
          titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
          onPress: () {
            _animationController!.reverse();
            DialogCustom.dialogCreateNote(title: _controllerTitle);
          },
        ),
      ],
      animation: _animation!,
      backGroundColor: primaryColor,
      iconColor: Colors.white,
      onPress: () => _animationController!.isCompleted
          ? _animationController!.reverse()
          : _animationController!.forward(),
    );
  }
}
