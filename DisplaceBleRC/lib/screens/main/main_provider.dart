import 'package:displacerc/screens/main/main_controller.dart';
import 'package:displacerc/screens/main/main_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainProvider =
    NotifierProvider<MainController, MainState>(MainController.new);