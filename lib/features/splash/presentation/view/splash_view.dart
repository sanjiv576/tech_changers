import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/splash_viewmodel.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      ref.read(splashViewModelProvider.notifier).init(context: context);

      // Navigator.popAndPushNamed(context, AppRoutes.loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/showJalLogo.png'),
            const Text('Version 1.0.0'),
            const SizedBox(
              height: 40,
            ),
            const Text('Developed by Tech Changers'),
          ],
        ),
      ),
    );
  }
}
