import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/config/router/app_routes.dart';
import 'package:my_project/core/shared_prefs/user_shared_prefs.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  void _showUserToken() async {
    UserSharedPrefs userSharedPrefs = UserSharedPrefs();
    var data = await userSharedPrefs.getUserToken();
    String? token;
    data.fold((l) => print(l.error.toString()), (r) => token = r!);

    print('Reading token from home : $token');
  }

  @override
  void initState() {
    super.initState();

    _showUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Text('Home'),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.loginRoute);
              },
              child: const Text('Logout'))
        ],
      )),
    );
  }
}
