import 'package:flutter/material.dart';

import '../screen_factory/screen_factory.dart';

abstract class Screens {
  static const home = '/home';
  static const process = '/process';
  static const results = '/results';
  static const preview = '/preview';
}

class MainNavigation {
  final _screenFactory = ScreenFactory();

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        Screens.home: (_) => _screenFactory.makeHomeScreen(),
        Screens.process: (_) => _screenFactory.makeProcessScreen(),
        Screens.results: (_) => _screenFactory.makeResultScreen(),
        Screens.preview: (BuildContext context) => _screenFactory.makePreviewScreen(context)
      };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }
}
