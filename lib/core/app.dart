import 'package:flutter/material.dart';

import '../config/router/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.getApplicationRoutes(),
      initialRoute: AppRoutes.splashRoute,
      
    );
  }
}
