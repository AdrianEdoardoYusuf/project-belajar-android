import 'dart:async';

import 'package:flutter/material.dart';

class AnimationBannerProvider extends ChangeNotifier {
  final ValueNotifier<int> _automaticIndex = ValueNotifier<int>(0);
  ValueNotifier<int> get automaticIndex => _automaticIndex;

  void animationMoveOtomation({required int length}) {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_automaticIndex.value == (length - 1)) {
        _automaticIndex.value = 0;
      } else {
        _automaticIndex.value++;
      }
    });
  }
}
