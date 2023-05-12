import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/global/global_context.dart';
import 'core/ui/theme/theme_config.dart';

class AppWidget extends StatelessWidget {
  final _navigatorkey = GlobalKey<NavigatorState>();
  AppWidget({super.key}) {
    GlobalContext.instance.navigatorKey = _navigatorkey;
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/login/');
    Modular.setNavigatorKey(_navigatorkey);

    return MaterialApp.router(
      title: 'Vakinhaburger Admin',
      theme: ThemeConfig.theme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
