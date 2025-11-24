import 'package:displacerc/core/screen/screen_controller.dart';
import 'package:displacerc/core/screen/screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final screenControllerProvider =
    NotifierProvider<ScreenController, ScreenState>(() {
      return ScreenController();
    });
