import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dashboard/home_view.dart';
import 'dashboard/profile_view.dart';
import 'dashboard/routine_view.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 1);

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  void _onTapItem(int index) {
    ref.watch(selectedIndexProvider.notifier).state = index;
  }

  final List<Widget> _screens = [
    const RoutineView(),
    const HomeView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  final List<CurvedNavigationBarItem> _navigationIcons = [
    const CurvedNavigationBarItem(
        label: 'Routine',
        child: Icon(
          Icons.view_list,
          // color: AppColorConstant.navigationIconColor,
        )),
    const CurvedNavigationBarItem(
        label: 'Home',
        child: Icon(
          Icons.home,
        )),
    const CurvedNavigationBarItem(
        label: 'Profile',
        child: Icon(
          Icons.person,
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          items: _navigationIcons,
          index: ref.watch(selectedIndexProvider),
          onTap: _onTapItem,
          // container background color
          color: Colors.yellow,

          buttonBackgroundColor: Colors.blue,

          backgroundColor: Colors.white,
          animationCurve: Curves.easeInSine,
          animationDuration: const Duration(milliseconds: 300),
        ),
        body: _screens.elementAt(ref.watch(selectedIndexProvider)));
  }
}
