import 'package:flutter/material.dart';
import 'package:pf/model/result/pathfinding_result.dart';
import 'package:pf/ui/screens/preview/preview_page.dart';
import 'package:pf/ui/screens/result/result.dart';

import '../screens/home/home_page.dart';
import '../screens/process/process.dart';

class ScreenFactory {
  Widget makeHomeScreen() => const HomePage();

  Widget makeProcessScreen() => const ProcessPage();

  Widget makeResultScreen() => const ResultPage();

  Widget makePreviewScreen(BuildContext context) {
    final PathfindingResult result = ModalRoute.of(context)!.settings.arguments as PathfindingResult;
    return PreviewPage(pathfindingResult: result);
  }
}
